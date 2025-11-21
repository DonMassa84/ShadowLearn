export interface GitHubUser {
  login: string;
  avatar_url: string;
  html_url: string;
  name: string;
  public_repos: number;
}

const GITHUB_TOKEN = (import.meta as any).env?.VITE_GITHUB_TOKEN;

export const fetchGitHubUser = async (): Promise<GitHubUser | null> => {
  if (!GITHUB_TOKEN) {
    console.warn("GitHub Token missing. Check .env file.");
    return null;
  }

  try {
    const response = await fetch("https://api.github.com/user", {
      headers: {
        Authorization: `token ${GITHUB_TOKEN}`,
        Accept: "application/vnd.github.v3+json",
      },
    });

    if (!response.ok) {
        console.error("GitHub API Error:", response.statusText);
        return null;
    }
    return await response.json();
  } catch (error) {
    console.error("GitHub Fetch Error:", error);
    return null;
  }
};

export const fetchCommitStreak = async (username: string): Promise<number> => {
  if (!GITHUB_TOKEN || !username) return 0;

  try {
    const response = await fetch(`https://api.github.com/users/${username}/events?per_page=100`, {
      headers: {
        Authorization: `token ${GITHUB_TOKEN}`,
        Accept: "application/vnd.github.v3+json",
      },
    });

    if (!response.ok) return 0;
    
    const events: any[] = await response.json();
    
    const pushEvents = events.filter((e: any) => e.type === "PushEvent" || e.type === "CreateEvent");
    
    if (pushEvents.length === 0) return 0;

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const activityDays = new Set(
      pushEvents.map((e: any) => new Date(e.created_at).toDateString())
    );

    let currentStreak = 0;
    for (let i = 0; i < 30; i++) {
      const dateToCheck = new Date(today);
      dateToCheck.setDate(today.getDate() - i);
      
      if (activityDays.has(dateToCheck.toDateString())) {
        currentStreak++;
      } else if (i === 0 && !activityDays.has(dateToCheck.toDateString())) {
        continue; 
      } else {
        break;
      }
    }

    return currentStreak;
  } catch (error) {
    console.error("GitHub Streak Error:", error);
    return 0;
  }
};

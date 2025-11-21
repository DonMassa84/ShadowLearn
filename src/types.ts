export enum DayStatus {
  LOCKED = 'locked',
  OPEN = 'open',
  COMPLETED = 'completed',
}

export interface Question {
  id: string;
  text: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

export interface CourseModule {
  id: string;
  courseId: string;
  title: string;
  shortCode: string;
  description: string;
  learningGoals: readonly string[];
  dayIds: readonly number[];
  recommendedPracticeTypes: readonly string[];
  estimatedMinutesTotal: number;
}

export interface CourseDay {
  id: string;
  dayNumber: number;
  title: string;
  description: string;
  estimatedMinutes: number;
  status: DayStatus;
  tags: string[];
  theoryContent: string;
  audioScript?: string;
  animationScript?: string;
  questions: Question[];
  bossLevelPrompt?: string;
}

export interface UserProgress {
  currentStreak: number;
  learningStreakDays: number;
  totalMinutesLearned: number;
  completedDays: string[];
  dayRatings: Record<string, { confidence: number; timestamp: number }>;
  energyLevel: number;
  preferredSessionLengths: number[];
  lastEnergyRating?: number;
}

export enum SessionPhase {
  BUILD = 'BUILD',
  PRACTICE = 'PRACTICE',
  REVIEW = 'REVIEW',
  LOG = 'LOG',
}

export type FlashcardDifficulty = "core" | "detail" | "challenge";

export interface Flashcard {
  id: string;
  courseId: string;
  moduleId: string;
  dayId?: number;
  topic: string;
  type: "definition" | "compare" | "case";
  front: string;
  back: string;
  difficulty: FlashcardDifficulty;
  tags?: string[];
}

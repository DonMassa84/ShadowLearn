import OpenAI from 'openai';

export interface BossQuestionResponse {
  text: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

const getClient = () => {
  const apiKey = (import.meta as any).env.VITE_OPENAI_API_KEY;
  
  if (!apiKey) {
    console.warn("OpenAI API Key is missing! Please check your .env file.");
    return null;
  }

  return new OpenAI({
    apiKey: apiKey,
    dangerouslyAllowBrowser: true 
  });
};

export const generateBossQuestion = async (topic: string): Promise<BossQuestionResponse | null> => {
  const client = getClient();
  if (!client) return null;

  try {
    const completion = await client.chat.completions.create({
      model: "gpt-4o",
      messages: [
        {
          role: "system",
          content: `You are a strict examiner for the German IHK 'Certified IT Business Manager' (Geprüfter IT-Projektleiter) exam.
          Your task is to create a "Boss Level" situational multiple-choice question.
          
          The question must:
          1. Be complex and scenario-based.
          2. Test deep understanding of IHK frameworks.
          3. Be strictly output as valid JSON.`
        },
        {
          role: "user",
          content: `Create a Boss Level question about: "${topic}".
          
          Return ONLY JSON with this structure:
          {
            "text": "The scenario and question...",
            "options": ["Option A", "Option B", "Option C", "Option D"],
            "correctIndex": 0, // 0-3 indicating the correct option
            "explanation": "Detailed reason why the answer is correct and others are wrong."
          }`
        }
      ],
      response_format: { type: "json_object" }
    });

    const content = completion.choices[0].message.content;
    if (!content) return null;

    return JSON.parse(content) as BossQuestionResponse;

  } catch (error) {
    console.error("OpenAI Boss Level Error:", error);
    return null;
  }
};

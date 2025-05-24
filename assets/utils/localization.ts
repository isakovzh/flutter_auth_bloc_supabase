import { promises as fs } from "fs";
import path from "path";

export type Language = "en" | "ru";

export async function getLessons(language: Language = "en") {
  try {
    const filePath = path.join(
      process.cwd(),
      "assets",
      "json",
      "locales",
      language,
      "lessons.json",
      "characters.json"
      
    );
    const fileContents = await fs.readFile(filePath, "utf8");
    return JSON.parse(fileContents);
  } catch (error) {
    console.error(`Error loading lessons for language ${language}:`, error);
    // Fallback to English if the requested language file doesn't exist
    if (language !== "en") {
      return getLessons("en");
    }
    throw error;
  }
}

// Helper function to check if a language is supported
export function isLanguageSupported(language: string): language is Language {
  return ["en", "ru"].includes(language);
}

// Get the list of supported languages
export function getSupportedLanguages(): Language[] {
  return ["en", "ru"];
}

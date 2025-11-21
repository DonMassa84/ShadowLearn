import React, { useEffect, useState } from 'react';
import { Flashcard } from '../../types';
import FlashcardItem from './FlashcardItem';
import { Play, Pause, SkipForward } from 'lucide-react';

interface PassiveCardStreamProps {
  cards: Flashcard[];
  autoFlipMs?: number;
  enabled?: boolean;
}

const PassiveCardStream: React.FC<PassiveCardStreamProps> = ({
  cards,
  autoFlipMs = 7000,
  enabled = true,
}) => {
  const [index, setIndex] = useState(0);
  const [running, setRunning] = useState(true);

  useEffect(() => {
    if (!enabled || !running || cards.length === 0) return;

    const timer = setTimeout(() => {
      setIndex((prev) => (prev + 1) % cards.length);
    }, autoFlipMs);

    return () => clearTimeout(timer);
  }, [enabled, running, autoFlipMs, cards.length, index]);

  if (!cards.length) {
    return (
      <div className="text-center text-gray-500 text-sm p-8 border border-gray-800 rounded-xl bg-gray-900/50">
        No flashcards available for the stream.
      </div>
    );
  }

  const currentCard = cards[index];

  const handleSkip = () => {
    setIndex((prev) => (prev + 1) % cards.length);
  };

  const togglePlay = () => {
    setRunning(!running);
  };

  return (
    <div className="flex flex-col items-center w-full max-w-xl mx-auto">
      <div className="flex items-center gap-3 text-gray-300 text-sm mb-6 bg-gray-900/80 p-2 rounded-full border border-gray-800 backdrop-blur-sm">
        <button
          type="button"
          onClick={togglePlay}
          className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gray-800 hover:bg-gray-700 transition-colors border border-gray-700 text-white"
        >
          {running ? (
            <>
              <Pause size={16} fill="currentColor" />
              <span>Pause</span>
            </>
          ) : (
            <>
              <Play size={16} fill="currentColor" />
              <span>Resume</span>
            </>
          )}
        </button>

        <button
          type="button"
          onClick={handleSkip}
          className="inline-flex items-center gap-2 px-3 py-2 rounded-full hover:bg-gray-800 text-gray-400 hover:text-white transition-colors"
        >
          <SkipForward size={16} />
          <span className="hidden sm:inline">Skip</span>
        </button>

        <div className="h-4 w-px bg-gray-700 mx-1"></div>

        <span className="text-xs text-gray-500 px-2 font-mono">
          {index + 1} / {cards.length}
        </span>
      </div>

      <div className="w-full transform transition-all duration-500">
        <FlashcardItem 
          card={currentCard} 
          passive 
          className="mb-4"
        />
      </div>
      
      {running && (
         <div className="w-full max-w-xs bg-gray-800 h-1 rounded-full overflow-hidden mt-4">
             <div 
               className="bg-brand-500 h-full animate-[width_7s_linear_infinite]" 
               key={index} 
             ></div>
         </div>
      )}
    </div>
  );
};

export default PassiveCardStream;

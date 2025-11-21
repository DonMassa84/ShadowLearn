import React, { useState } from 'react';
import { Flashcard } from '../../types';
import { Repeat, CheckCircle2, XCircle, Eye } from 'lucide-react';

interface FlashcardItemProps {
  card: Flashcard;
  passive?: boolean;
  onKnow?: (id: string) => void;
  onDontKnow?: (id: string) => void;
  className?: string;
}

const FlashcardItem: React.FC<FlashcardItemProps> = ({ 
  card, 
  passive = false, 
  onKnow, 
  onDontKnow,
  className = '' 
}) => {
  const [isFlipped, setIsFlipped] = useState(false);

  const handleFlip = () => {
    setIsFlipped(!isFlipped);
  };

  const getBorderColor = () => {
    switch(card.difficulty) {
      case 'core': return 'border-brand-500/50';
      case 'detail': return 'border-accent-500/50';
      case 'challenge': return 'border-red-500/50';
      default: return 'border-gray-700';
    }
  };

  return (
    <div className={`perspective-1000 w-full max-w-xl mx-auto h-80 cursor-pointer group ${className}`} onClick={handleFlip}>
      <div className={`relative w-full h-full transition-all duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}>
        
        <div className={`absolute w-full h-full backface-hidden bg-gray-900 rounded-2xl border-2 ${getBorderColor()} shadow-xl p-6 md:p-8 flex flex-col`}>
           <div className="flex justify-between items-center mb-4 text-xs text-gray-400 font-medium uppercase tracking-wider">
              <span>{card.topic}</span>
              <span className="flex items-center gap-1 bg-gray-800 px-2 py-1 rounded border border-gray-700">
                <Repeat size={12}/> {card.type}
              </span>
           </div>
           <div className="flex-1 flex items-center justify-center text-center">
             <p className="text-xl md:text-2xl text-white font-medium leading-relaxed">{card.front}</p>
           </div>
           <div className="mt-4 text-center text-xs text-gray-600 flex items-center justify-center gap-2">
             {passive ? <Eye size={12} /> : null} 
             {passive ? "Auto-flip enabled" : "Tap to flip"}
           </div>
        </div>

        <div className={`absolute w-full h-full backface-hidden rotate-y-180 bg-gray-800 rounded-2xl border-2 border-gray-600 shadow-xl p-6 md:p-8 flex flex-col`}>
           <div className="flex justify-between items-center mb-4 text-xs text-gray-400 font-medium uppercase tracking-wider">
              <span>Answer</span>
              {passive && <span className="text-brand-400 bg-brand-900/20 px-2 py-0.5 rounded text-[10px]">Passive</span>}
           </div>
           
           <div className="flex-1 flex items-center justify-center text-center overflow-y-auto custom-scrollbar">
             <p className="text-lg md:text-xl text-white leading-relaxed">{card.back}</p>
           </div>

           {!passive && (
             <div className="mt-6 flex gap-3 pt-4 border-t border-gray-700" onClick={(e) => e.stopPropagation()}>
                <button 
                  onClick={() => onDontKnow?.(card.id)}
                  className="flex-1 flex items-center justify-center gap-2 py-2 rounded-lg border border-red-500/50 text-red-400 hover:bg-red-500/10 transition-colors"
                >
                  <XCircle size={18} /> Hard
                </button>
                <button 
                  onClick={() => onKnow?.(card.id)}
                  className="flex-1 flex items-center justify-center gap-2 py-2 rounded-lg border border-brand-500/50 text-brand-400 hover:bg-brand-500/10 transition-colors"
                >
                   <CheckCircle2 size={18} /> Easy
                </button>
             </div>
           )}
        </div>
      </div>
      
      <style>{`
        .perspective-1000 { perspective: 1000px; }
        .transform-style-3d { transform-style: preserve-3d; }
        .backface-hidden { backface-visibility: hidden; }
        .rotate-y-180 { transform: rotateY(180deg); }
      `}</style>
    </div>
  );
};

export default FlashcardItem;

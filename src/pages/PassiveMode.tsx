import React, { useState, useEffect } from 'react';
import { MOCK_COURSE_DAYS, MOCK_FLASHCARDS } from '../constants';
import PassiveCardStream from '../components/ui/PassiveCardStream';
import { Play, Pause, SkipForward, Headphones, Layers, Volume2 } from 'lucide-react';

const PassiveMode: React.FC = () => {
  const [mode, setMode] = useState<'audio' | 'cards'>('audio');
  const [isAudioPlaying, setIsAudioPlaying] = useState(true);
  
  const audioDays = MOCK_COURSE_DAYS.filter(d => d.audioScript);
  const [audioIndex, setAudioIndex] = useState(0);
  
  useEffect(() => {
     if (mode === 'audio' && isAudioPlaying) {
        const timer = setInterval(() => {
           setAudioIndex(prev => (prev + 1) % audioDays.length);
        }, 8000); 
        return () => clearInterval(timer);
     }
  }, [mode, isAudioPlaying, audioDays.length]);

  const currentAudioDay = audioDays[audioIndex];

  return (
    <div className="max-w-2xl mx-auto space-y-8 animate-in fade-in duration-500 pb-20">
      <header className="text-center mb-8">
        <h1 className="text-3xl font-bold text-white mb-2">Passive Mode</h1>
        <p className="text-gray-400">Lean back. Absorb. Repeat.</p>
      </header>

      <div className="flex justify-center mb-12">
         <div className="bg-gray-900 p-1.5 rounded-xl border border-gray-800 inline-flex shadow-lg">
            <button 
              onClick={() => setMode('audio')}
              className={`px-6 py-2.5 rounded-lg flex items-center gap-2 transition-all font-medium text-sm ${mode === 'audio' ? 'bg-gray-800 text-white shadow-md ring-1 ring-white/5' : 'text-gray-500 hover:text-gray-300'}`}
            >
               <Headphones size={18} /> Audio Loop
            </button>
            <button 
              onClick={() => setMode('cards')}
              className={`px-6 py-2.5 rounded-lg flex items-center gap-2 transition-all font-medium text-sm ${mode === 'cards' ? 'bg-gray-800 text-white shadow-md ring-1 ring-white/5' : 'text-gray-500 hover:text-gray-300'}`}
            >
               <Layers size={18} /> Card Stream
            </button>
         </div>
      </div>

      <div className="min-h-[400px] flex flex-col items-center justify-start">
         
         {mode === 'audio' && currentAudioDay && (
           <div className="w-full bg-gray-900 p-8 rounded-2xl border border-gray-800 text-center shadow-2xl relative overflow-hidden animate-in zoom-in-95 duration-300">
              <div className="absolute top-0 left-0 w-full h-1 bg-gray-800">
                 <div className={`h-full bg-brand-500 ${isAudioPlaying ? 'animate-[width_8s_linear_infinite]' : 'w-1/2'}`}></div>
              </div>

              <div className="w-24 h-24 bg-gray-800 rounded-full mx-auto flex items-center justify-center mb-6 shadow-inner ring-1 ring-white/5">
                 <Volume2 size={40} className={`text-brand-400 ${isAudioPlaying ? 'animate-pulse' : ''}`} />
              </div>
              
              <h2 className="text-2xl font-bold text-white mb-2">{currentAudioDay.title}</h2>
              <p className="text-gray-500 text-sm uppercase tracking-wider mb-8">Day {currentAudioDay.dayNumber}</p>

              <div className="bg-gray-950/50 p-6 rounded-xl text-gray-300 italic leading-relaxed mb-8 border border-gray-800/50">
                "{currentAudioDay.audioScript}"
              </div>

              <div className="flex justify-center gap-6">
                 <button 
                   onClick={() => setIsAudioPlaying(!isAudioPlaying)}
                   className="w-16 h-16 rounded-full bg-brand-600 hover:bg-brand-500 text-white flex items-center justify-center shadow-lg shadow-brand-900/20 transition-transform hover:scale-105"
                 >
                    {isAudioPlaying ? <Pause size={28} fill="currentColor" /> : <Play size={28} fill="currentColor" className="ml-1" />}
                 </button>
                 <button 
                   onClick={() => setAudioIndex((prev) => (prev + 1) % audioDays.length)}
                   className="w-16 h-16 rounded-full bg-gray-800 hover:bg-gray-700 text-gray-300 flex items-center justify-center border border-gray-700 transition-colors"
                 >
                    <SkipForward size={28} />
                 </button>
              </div>
           </div>
         )}

         {mode === 'cards' && (
            <PassiveCardStream 
              cards={MOCK_FLASHCARDS} 
              autoFlipMs={7000} 
              enabled={true} 
            />
         )}

      </div>
    </div>
  );
};

export default PassiveMode;

import React, { useState, useMemo } from 'react';
import { MOCK_FLASHCARDS } from '../constants';
import FlashcardItem from '../components/ui/FlashcardItem';
import Button from '../components/ui/Button';
import { Filter, Zap } from 'lucide-react';

const Flashcards: React.FC = () => {
  const [drillMode, setDrillMode] = useState(false);
  const [activeDrillCards, setActiveDrillCards] = useState<typeof MOCK_FLASHCARDS>([]);
  const [drillIndex, setDrillIndex] = useState(0);

  const [filterTopic, setFilterTopic] = useState<string | null>(null);
  
  const availableTopics = useMemo(() => {
    return Array.from(new Set(MOCK_FLASHCARDS.map(c => c.topic)));
  }, []);

  const filteredCards = useMemo(() => {
    if (!filterTopic) return MOCK_FLASHCARDS;
    return MOCK_FLASHCARDS.filter(c => c.topic === filterTopic);
  }, [filterTopic]);

  const startDrill = () => {
    const shuffled = [...filteredCards].sort(() => 0.5 - Math.random());
    setActiveDrillCards(shuffled.slice(0, 5));
    setDrillIndex(0);
    setDrillMode(true);
  };

  const handleCardResult = (id: string, result: 'know' | 'dontknow') => {
    console.log(`Card ${id}: ${result}`);
    
    if (drillIndex < activeDrillCards.length - 1) {
      setTimeout(() => setDrillIndex(prev => prev + 1), 300);
    } else {
      alert("Drill Complete! Great work.");
      setDrillMode(false);
    }
  };

  if (drillMode) {
    const card = activeDrillCards[drillIndex];
    const progress = ((drillIndex) / activeDrillCards.length) * 100;
    
    return (
      <div className="max-w-2xl mx-auto h-full flex flex-col pt-4">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-xl font-bold text-white flex items-center gap-2">
            <Zap className="text-yellow-500 fill-yellow-500" size={20} /> 
            5-Card Drill
          </h2>
          <button onClick={() => setDrillMode(false)} className="text-gray-500 hover:text-white">Exit</button>
        </div>
        
        <div className="w-full bg-gray-800 h-1.5 rounded-full mb-8 overflow-hidden">
           <div className="bg-brand-500 h-full transition-all duration-300" style={{ width: `${progress}%` }}></div>
        </div>

        <div className="flex-1 flex flex-col justify-center items-center pb-20">
          <div className="text-gray-400 text-sm mb-4">Card {drillIndex + 1} of {activeDrillCards.length}</div>
          <FlashcardItem 
             key={card.id} 
             card={card} 
             onKnow={() => handleCardResult(card.id, 'know')}
             onDontKnow={() => handleCardResult(card.id, 'dontknow')}
          />
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-8 animate-in fade-in duration-500">
      <header className="mb-8">
        <h1 className="text-3xl font-bold text-white mb-2">Flashcards</h1>
        <p className="text-gray-400">Master definitions and core concepts.</p>
      </header>

      <div className="bg-gray-900 p-4 rounded-xl border border-gray-800 flex flex-col md:flex-row gap-4 items-center justify-between">
        <div className="flex items-center gap-2 w-full md:w-auto">
           <Filter size={18} className="text-gray-500" />
           <select 
             className="bg-gray-800 text-gray-200 text-sm rounded-lg border-none focus:ring-1 focus:ring-brand-500 py-2 pl-3 pr-8"
             value={filterTopic || ''}
             onChange={(e) => setFilterTopic(e.target.value || null)}
           >
             <option value="">All Topics</option>
             {availableTopics.map(t => <option key={t} value={t}>{t}</option>)}
           </select>
           <span className="text-gray-600 text-sm ml-2">{filteredCards.length} cards</span>
        </div>

        <Button onClick={startDrill} disabled={filteredCards.length === 0} className="w-full md:w-auto">
           <Zap size={18} className="mr-2 fill-white/20" /> Start 5-Card Drill
        </Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {filteredCards.map(card => (
          <div key={card.id} className="bg-gray-900 border border-gray-800 p-4 rounded-lg hover:border-gray-700 transition-colors">
            <div className="flex justify-between items-start mb-2">
               <span className="text-xs font-bold text-gray-500 uppercase">{card.topic}</span>
               <span className={`text-[10px] px-1.5 py-0.5 rounded border ${card.difficulty === 'core' ? 'border-brand-900 text-brand-400' : 'border-gray-700 text-gray-400'}`}>
                 {card.difficulty}
               </span>
            </div>
            <p className="text-gray-200 font-medium mb-4 line-clamp-2">{card.front}</p>
            <div className="text-xs text-gray-600 border-t border-gray-800 pt-2">
               Answer hidden in library view
            </div>
          </div>
        ))}
      </div>
      
      {filteredCards.length === 0 && (
         <div className="text-center py-20 text-gray-500">
            No cards found for this topic.
         </div>
      )}

    </div>
  );
};

export default Flashcards;

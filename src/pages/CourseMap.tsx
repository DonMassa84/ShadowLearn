import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Check, Lock, Play, Star } from 'lucide-react';
import { MOCK_COURSE_DAYS, COURSE_MODULES } from '../constants';
import { DayStatus } from '../types';

const CourseMap: React.FC = () => {
  const navigate = useNavigate();

  const getModuleForDay = (dayNumber: number) => {
    return COURSE_MODULES.find(m => m.dayIds.includes(dayNumber));
  };

  return (
    <div className="animate-in slide-in-from-bottom-4 duration-500 pb-12">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-white mb-2">Mitarbeiterführung</h1>
        <p className="text-gray-400">Der 14-Tage Sprint zum IHK-Erfolg.</p>
      </div>

      <div className="relative">
        <div className="absolute left-6 md:left-1/2 top-0 bottom-0 w-0.5 bg-gray-800 transform -translate-x-1/2"></div>

        <div className="space-y-8">
          {MOCK_COURSE_DAYS.map((day, index) => {
            const module = getModuleForDay(day.dayNumber);
            const isFirstDayOfModule = module && module.dayIds[0] === day.dayNumber;
            
            const isLeft = index % 2 === 0;
            const status = day.status;
            const isCompleted = status === DayStatus.COMPLETED;
            const isOpen = status === DayStatus.OPEN;
            const isLocked = status === DayStatus.LOCKED;

            return (
              <div key={day.id}>
                {isFirstDayOfModule && (
                   <div className="relative flex justify-center mb-8 mt-8 first:mt-0">
                      <div className="bg-gray-800 border border-gray-700 rounded-lg px-4 py-2 shadow-xl z-10 flex items-center space-x-2">
                        <span className="bg-brand-900/50 text-brand-400 text-xs font-bold px-2 py-0.5 rounded border border-brand-500/30">
                          {module.shortCode}
                        </span>
                        <span className="text-sm font-medium text-gray-200">{module.title}</span>
                      </div>
                   </div>
                )}

                <div className={`relative flex md:justify-center items-center ${!isLeft && 'md:flex-row-reverse'}`}>
                  
                  <div className="absolute left-6 md:left-1/2 transform -translate-x-1/2 z-10">
                    <div className={`
                      w-10 h-10 rounded-full flex items-center justify-center border-4 transition-all duration-300
                      ${isCompleted ? 'bg-brand-500 border-brand-900 text-white scale-100' : ''}
                      ${isOpen ? 'bg-gray-900 border-brand-500 animate-pulse text-brand-500 scale-110 shadow-[0_0_15px_rgba(16,185,129,0.5)]' : ''}
                      ${isLocked ? 'bg-gray-900 border-gray-800 text-gray-700' : ''}
                    `}>
                      {isCompleted ? <Check size={16} strokeWidth={3} /> : 
                       isOpen ? <Play size={16} className="ml-0.5" fill="currentColor" /> : 
                       <Lock size={16} />}
                    </div>
                  </div>

                  <div className={`
                    ml-16 md:ml-0 md:w-[45%] 
                    ${isLeft ? 'md:mr-auto md:pr-12 md:text-right' : 'md:ml-auto md:pl-12 md:text-left'}
                  `}>
                    <div 
                      onClick={() => !isLocked && navigate(`/session/${day.id}`)}
                      className={`
                        group p-5 rounded-xl border transition-all duration-300
                        ${isOpen 
                          ? 'bg-gray-800 border-brand-500/50 shadow-lg shadow-brand-900/20 cursor-pointer hover:scale-[1.02] hover:border-brand-400' 
                          : isCompleted 
                            ? 'bg-gray-900 border-gray-800 opacity-75 hover:opacity-100 cursor-pointer hover:border-gray-700' 
                            : 'bg-gray-900/30 border-gray-800/50 opacity-50 cursor-not-allowed'}
                      `}
                    >
                      <div className={`flex flex-col ${isLeft ? 'md:items-end' : 'md:items-start'}`}>
                        <span className={`
                          text-[10px] font-bold uppercase tracking-wider mb-1
                          ${isOpen ? 'text-brand-400' : 'text-gray-500'}
                        `}>
                          Day {day.dayNumber}
                        </span>
                        <h3 className={`text-lg font-bold mb-2 group-hover:text-white transition-colors ${isOpen ? 'text-white' : 'text-gray-300'}`}>
                          {day.title}
                        </h3>
                        <p className="text-gray-400 text-sm mb-3 line-clamp-2">
                          {day.description}
                        </p>
                        
                        <div className={`flex flex-wrap gap-2 ${isLeft ? 'md:justify-end' : 'md:justify-start'}`}>
                          {day.tags.map(tag => (
                            <span key={tag} className="px-2 py-0.5 bg-gray-950/50 rounded text-[10px] text-gray-500 border border-gray-800/50">
                              {tag}
                            </span>
                          ))}
                        </div>

                        {isOpen && (
                           <div className={`mt-4 flex items-center text-xs font-bold text-brand-400 uppercase tracking-widest ${isLeft ? 'flex-row-reverse' : ''}`}>
                             <span>Start Session</span>
                             <Play size={10} className={`fill-current ${isLeft ? 'mr-1 rotate-180' : 'ml-1'}`} />
                           </div>
                        )}
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            );
          })}

           <div className="relative flex justify-center pt-12 pb-12">
              <div className="w-16 h-16 bg-accent-500/10 rounded-full flex items-center justify-center border-2 border-accent-500 animate-bounce shadow-[0_0_30px_rgba(245,158,11,0.3)]">
                <Star className="text-accent-500 fill-accent-500" size={28} />
              </div>
           </div>

        </div>
      </div>
    </div>
  );
};

export default CourseMap;

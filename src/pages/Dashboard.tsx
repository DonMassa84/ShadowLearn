import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Play, Flame, Clock, CheckCircle2, Lock, ChevronRight, Zap, Layers, Headphones, Github } from 'lucide-react';
import { MOCK_COURSE_DAYS, MOCK_USER_PROGRESS } from '../constants';
import { DayStatus } from '../types';
import Button from '../components/ui/Button';
import ProgressBar from '../components/ui/ProgressBar';
import { fetchGitHubUser, fetchCommitStreak, GitHubUser } from '../services/githubService';

const Dashboard: React.FC = () => {
  const navigate = useNavigate();
  const [ghUser, setGhUser] = useState<GitHubUser | null>(null);
  const [ghStreak, setGhStreak] = useState(0);

  useEffect(() => {
    const loadGitHubData = async () => {
      const user = await fetchGitHubUser();
      if (user) {
        setGhUser(user);
        const streak = await fetchCommitStreak(user.login);
        setGhStreak(streak);
      }
    };
    loadGitHubData();
  }, []);
  
  const nextDay = MOCK_COURSE_DAYS.find(day => day.status === DayStatus.OPEN) || MOCK_COURSE_DAYS[0];
  const progress = MOCK_USER_PROGRESS;
  const totalDays = MOCK_COURSE_DAYS.length;
  const completedCount = MOCK_COURSE_DAYS.filter(d => d.status === DayStatus.COMPLETED).length;

  const startSession = (minutes: number) => {
    navigate(`/session/${nextDay.id}?duration=${minutes}`);
  };

  return (
    <div className="space-y-8 animate-in fade-in duration-500">
      <header className="flex justify-between items-center">
        <div className="flex items-center space-x-4">
          {ghUser ? (
            <img src={ghUser.avatar_url} alt={ghUser.login} className="w-14 h-14 rounded-full border-2 border-brand-500 shadow-lg" />
          ) : (
            <div className="h-14 w-14 rounded-full bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center font-bold text-white shadow-md text-xl">
              DM
            </div>
          )}
          <div>
            <h1 className="text-3xl font-bold text-white">
              {ghUser ? `Moin, ${ghUser.name || ghUser.login}` : 'Moin, Daniel!'}
            </h1>
            <p className="text-gray-400 text-sm mt-1">
              {ghUser ? 'GitHub Active • Ready to build & learn.' : 'Bereit für den nächsten Sprint?'}
            </p>
          </div>
        </div>

        <div className="flex flex-col items-end space-y-2">
          <div className="flex items-center space-x-2 bg-gray-800/50 px-3 py-1.5 rounded-full border border-gray-700/50">
            <Flame className="text-orange-500 fill-orange-500" size={18} />
            <span className="text-orange-100 font-bold">{progress.learningStreakDays} Day Study Streak</span>
          </div>
          
          {ghUser && (
            <div className="flex items-center space-x-2 bg-gray-900 px-3 py-1.5 rounded-full border border-gray-800">
              <Github className="text-white" size={16} />
              <span className="text-gray-300 text-xs font-medium">{ghStreak} Days Dev Streak</span>
            </div>
          )}
        </div>
      </header>

      <section className="relative group">
        <div className="absolute -inset-0.5 bg-gradient-to-r from-brand-500 to-accent-500 rounded-2xl opacity-75 blur opacity-20 group-hover:opacity-40 transition duration-500"></div>
        <div className="relative bg-gray-900 rounded-2xl p-6 md:p-8 border border-gray-800 shadow-2xl">
          <div className="flex flex-col md:flex-row md:justify-between md:items-start gap-6">
            
            <div className="space-y-4 flex-1">
              <div className="flex items-center space-x-2">
                 <span className="text-brand-400 bg-brand-900/20 px-2.5 py-0.5 rounded text-xs font-semibold uppercase tracking-wide">
                   Today's Mission
                 </span>
                 <span className="text-gray-500 text-xs uppercase tracking-wider font-medium">
                   Build • Practice • Review • Log
                 </span>
              </div>
              
              <div>
                <h2 className="text-2xl md:text-4xl font-bold text-white mb-2">{nextDay.title}</h2>
                <p className="text-gray-400 text-lg leading-relaxed max-w-xl">
                  {nextDay.description}
                </p>
              </div>

              <div className="flex items-center space-x-6 text-sm text-gray-400">
                <div className="flex items-center space-x-1.5">
                  <Clock size={16} className="text-accent-400" />
                  <span>Est. {nextDay.estimatedMinutes} Min</span>
                </div>
                <div className="flex items-center space-x-1.5">
                  <span className="bg-gray-800 px-2 py-0.5 rounded text-xs border border-gray-700">
                    Day {nextDay.dayNumber} / {totalDays}
                  </span>
                </div>
              </div>
            </div>

            <div className="flex flex-col w-full md:w-auto space-y-3 min-w-[220px]">
              <Button 
                size="lg" 
                className="w-full justify-between group-hover:scale-105 transition-transform bg-gradient-to-r from-brand-600 to-brand-500"
                onClick={() => startSession(30)}
              >
                <span className="flex flex-col items-start">
                  <span className="font-bold">Start Session</span>
                  <span className="text-[10px] opacity-80 font-normal">30 Min Focus Block</span>
                </span>
                <Play size={24} className="fill-current" />
              </Button>
              
              <div className="grid grid-cols-2 gap-2">
                <Button variant="secondary" size="sm" onClick={() => startSession(60)}>
                  ⏱ 60 Min
                </Button>
                <Button variant="secondary" size="sm" onClick={() => navigate(`/session/${nextDay.id}?mode=quick`)}>
                  ⚡ Quick Drill
                </Button>
              </div>
            </div>

          </div>
        </div>
      </section>

      <section className="grid grid-cols-1 md:grid-cols-2 gap-6">
         <div 
            onClick={() => navigate('/flashcards')}
            className="bg-gray-900 p-6 rounded-xl border border-gray-800 hover:border-brand-500/30 cursor-pointer group transition-all"
         >
            <div className="flex justify-between items-start mb-4">
               <div className="bg-blue-900/20 p-3 rounded-lg text-blue-400 group-hover:bg-blue-900/30 group-hover:text-blue-300 transition-colors">
                  <Layers size={24} />
               </div>
               <Zap size={16} className="text-gray-700 group-hover:text-yellow-500 transition-colors" />
            </div>
            <h3 className="text-lg font-bold text-white mb-1">Flashcards</h3>
            <p className="text-gray-400 text-sm">Train definitions. Start a 5-Card Drill.</p>
         </div>

         <div 
            onClick={() => navigate('/passive')}
            className="bg-gray-900 p-6 rounded-xl border border-gray-800 hover:border-purple-500/30 cursor-pointer group transition-all"
         >
            <div className="flex justify-between items-start mb-4">
               <div className="bg-purple-900/20 p-3 rounded-lg text-purple-400 group-hover:bg-purple-900/30 group-hover:text-purple-300 transition-colors">
                  <Headphones size={24} />
               </div>
               <span className="text-xs font-medium text-gray-500 group-hover:text-purple-400">Low Energy?</span>
            </div>
            <h3 className="text-lg font-bold text-white mb-1">Passive Mode</h3>
            <p className="text-gray-400 text-sm">Lean back. Audio loops & Auto-stream.</p>
         </div>
      </section>

      <section className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="bg-gray-900 p-6 rounded-xl border border-gray-800">
          <div className="flex justify-between items-center mb-4">
            <h3 className="font-semibold text-white">Course Progress</h3>
            <span className="text-brand-400 font-mono text-sm">{Math.round((completedCount / totalDays) * 100)}%</span>
          </div>
          <ProgressBar current={completedCount} total={totalDays} />
          <div className="mt-4 text-sm text-gray-400">
            {completedCount} of {totalDays} modules completed.
          </div>
        </div>

        <div className="bg-gray-900 p-6 rounded-xl border border-gray-800">
           <div className="flex justify-between items-center mb-4">
            <h3 className="font-semibold text-white">Focus Energy</h3>
            <div className="flex items-center space-x-1">
              <Zap size={14} className="text-accent-400 fill-accent-400" />
              <span className="text-accent-400 font-mono text-sm">Level {progress.energyLevel}/5</span>
            </div>
          </div>
          <div className="flex space-x-2">
            {[1, 2, 3, 4, 5].map((level) => (
              <div 
                key={level}
                className={`h-8 flex-1 rounded-md flex items-center justify-center text-xs font-bold transition-all
                  ${level <= progress.energyLevel 
                    ? 'bg-accent-500 text-gray-900 shadow-lg shadow-accent-500/20' 
                    : 'bg-gray-800 text-gray-600'}`}
              >
                {level}
              </div>
            ))}
          </div>
          <p className="mt-4 text-sm text-gray-400">High energy? Try the Boss Level.</p>
        </div>
      </section>

      <section>
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-lg font-semibold text-white">Up Next</h3>
          <Button variant="ghost" size="sm" onClick={() => navigate('/map')}>View Map</Button>
        </div>
        <div className="space-y-3">
          {MOCK_COURSE_DAYS.slice(0, 4).map((day) => {
            const isLocked = day.status === DayStatus.LOCKED;
            const isCompleted = day.status === DayStatus.COMPLETED;
            
            return (
              <div 
                key={day.id}
                className={`flex items-center p-4 rounded-lg border transition-colors
                  ${day.id === nextDay.id ? 'bg-gray-800/50 border-brand-500/30 ring-1 ring-brand-500/20' : 'bg-gray-900 border-gray-800'}
                  ${isLocked ? 'opacity-50' : 'hover:border-gray-700 cursor-pointer'}
                `}
                onClick={() => !isLocked && navigate(`/session/${day.id}`)}
              >
                <div className="mr-4 flex-shrink-0">
                  {isCompleted ? (
                    <CheckCircle2 className="text-brand-500" />
                  ) : isLocked ? (
                    <Lock className="text-gray-600" />
                  ) : (
                    <div className="w-6 h-6 rounded-full border-2 border-brand-500 flex items-center justify-center">
                      <div className="w-2 h-2 bg-brand-500 rounded-full animate-pulse"></div>
                    </div>
                  )}
                </div>
                <div className="flex-1">
                  <h4 className={`font-medium ${isCompleted ? 'text-gray-400 line-through' : 'text-white'}`}>
                    Day {day.dayNumber}: {day.title}
                  </h4>
                  <div className="flex space-x-2 mt-1">
                    {day.tags.map(tag => (
                      <span key={tag} className="text-[10px] px-1.5 py-0.5 bg-gray-800 rounded text-gray-400">
                        {tag}
                      </span>
                    ))}
                  </div>
                </div>
                {!isLocked && <ChevronRight size={18} className="text-gray-600" />}
              </div>
            )
          })}
        </div>
      </section>

    </div>
  );
};

export default Dashboard;

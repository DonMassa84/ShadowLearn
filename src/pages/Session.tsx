import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { X, Volume2, Pause, ArrowRight, CheckCircle, Zap, Copy, BrainCircuit } from 'lucide-react';
import { MOCK_COURSE_DAYS } from '../constants';
import { SessionPhase, CourseDay, Question } from '../types';
import Button from '../components/ui/Button';
import { generateBossQuestion } from '../services/openaiService';

const Session: React.FC = () => {
  const { dayId } = useParams<{ dayId: string }>();
  const [searchParams] = useSearchParams();
  const mode = searchParams.get('mode'); 
  const duration = searchParams.get('duration');

  const navigate = useNavigate();
  const [day, setDay] = useState<CourseDay | null>(null);
  const [phase, setPhase] = useState<SessionPhase>(SessionPhase.BUILD);
  const [isPlayingAudio, setIsPlayingAudio] = useState(false);
  
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswerChecked, setIsAnswerChecked] = useState(false);
  const [score, setScore] = useState(0);
  
  const [isGenerating, setIsGenerating] = useState(false);

  const [confidenceRating, setConfidenceRating] = useState<number | 0>(0);
  const [energyRating, setEnergyRating] = useState<number | 0>(0);

  useEffect(() => {
    const foundDay = MOCK_COURSE_DAYS.find(d => d.id === dayId);
    if (foundDay) {
      setDay(foundDay);
      setQuestions(foundDay.questions);
      if (mode === 'quick') {
        setPhase(SessionPhase.PRACTICE);
      }
    } else {
      navigate('/');
    }
  }, [dayId, navigate, mode]);

  if (!day) return null;

  const handleBuildComplete = () => {
    setPhase(SessionPhase.PRACTICE);
  };

  const handleAnswerSelect = (index: number) => {
    if (isAnswerChecked) return;
    setSelectedOption(index);
  };

  const handleCheckAnswer = () => {
    setIsAnswerChecked(true);
    if (selectedOption === questions[currentQuestionIndex].correctIndex) {
      setScore(s => s + 1);
    }
  };

  const handleNextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
      setSelectedOption(null);
      setIsAnswerChecked(false);
    } else {
      setPhase(SessionPhase.REVIEW);
    }
  };

  const handleGenerateBossQuestion = async () => {
    if (isGenerating) return;
    setIsGenerating(true);
    
    const topic = `${day.title} (Focus: ${day.tags.join(', ')})`;
    const bossQ = await generateBossQuestion(topic);
    
    if (bossQ) {
      const newQ: Question = {
        id: "boss-" + Date.now().toString(),
        text: bossQ.text,
        options: bossQ.options,
        correctIndex: bossQ.correctIndex,
        explanation: bossQ.explanation
      };
      
      setQuestions(prev => [...prev, newQ]);
      setCurrentQuestionIndex(questions.length);
      setSelectedOption(null);
      setIsAnswerChecked(false);
    } else {
        alert("Could not generate Boss Question. Check API Key in .env");
    }
    setIsGenerating(false);
  };

  const handleReviewComplete = () => {
    setPhase(SessionPhase.LOG);
  };

  const handleFinishSession = () => {
    setTimeout(() => {
      navigate('/');
    }, 1000);
  };

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
    alert("Copied to clipboard!");
  };

  const renderPhaseIndicator = () => {
    const steps = [
      { id: SessionPhase.BUILD, label: 'Build' },
      { id: SessionPhase.PRACTICE, label: 'Practice' },
      { id: SessionPhase.REVIEW, label: 'Review' },
      { id: SessionPhase.LOG, label: 'Log' }
    ];
    
    const filteredSteps = mode === 'quick' ? steps.filter(s => s.id !== SessionPhase.BUILD) : steps;

    return (
      <div className="flex justify-center mb-8 space-x-2">
        {filteredSteps.map((step) => {
          const isActive = step.id === phase;
          return (
            <div 
              key={step.id} 
              className={`
                px-4 py-1.5 rounded-full text-xs font-bold uppercase tracking-wider transition-all
                ${isActive 
                  ? 'bg-brand-500 text-white shadow-lg shadow-brand-900/40 scale-105' 
                  : 'bg-gray-800 text-gray-500'}
              `}
            >
              {step.label}
            </div>
          );
        })}
      </div>
    );
  };

  const renderBuild = () => (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-500">
      <div className="bg-gray-900 p-6 md:p-8 rounded-2xl border border-gray-800 shadow-xl">
        <div className="flex justify-between items-start mb-6">
           <h3 className="text-3xl font-bold text-white">{day.title}</h3>
           {day.animationScript && (
             <button 
               onClick={() => copyToClipboard(day.animationScript || "")}
               title="Copy AI Video Prompt"
               className="p-2 bg-gray-800 hover:bg-gray-700 rounded-lg text-gray-400 hover:text-white transition-colors"
             >
               <Copy size={18} />
             </button>
           )}
        </div>
        
        {day.audioScript && (
          <div className="bg-gray-800 rounded-xl p-4 mb-8 flex items-center justify-between border border-gray-700 shadow-inner">
             <div className="flex items-center space-x-4">
               <button 
                 onClick={() => setIsPlayingAudio(!isPlayingAudio)}
                 className="w-12 h-12 rounded-full bg-brand-500 flex items-center justify-center hover:bg-brand-400 transition-colors text-white shadow-lg shadow-brand-900/20"
               >
                 {isPlayingAudio ? <Pause size={20} fill="currentColor" /> : <Volume2 size={20} />}
               </button>
               <div>
                 <p className="text-sm font-medium text-white">Audio Lesson</p>
                 <p className="text-xs text-gray-400">Listen while you move</p>
               </div>
             </div>
             {isPlayingAudio && (
               <div className="flex space-x-1 h-4 items-end pr-2">
                 <div className="w-1 bg-brand-400 h-full animate-[pulse_1s_ease-in-out_infinite]"></div>
                 <div className="w-1 bg-brand-400 h-2 animate-[pulse_1.5s_ease-in-out_infinite]"></div>
                 <div className="w-1 bg-brand-400 h-3 animate-[pulse_0.8s_ease-in-out_infinite]"></div>
               </div>
             )}
          </div>
        )}

        <div className="prose prose-invert prose-lg max-w-none text-gray-300 mb-10 leading-relaxed whitespace-pre-wrap">
           {day.theoryContent}
        </div>

        <Button fullWidth size="lg" onClick={handleBuildComplete}>
          I understand. Let's Practice <ArrowRight className="ml-2" size={18} />
        </Button>
      </div>
    </div>
  );

  const renderPractice = () => {
    if (questions.length === 0) return (
      <div className="text-center bg-gray-900 p-8 rounded-xl border border-gray-800">
        <h3 className="text-white text-xl mb-4">No questions configured for this day.</h3>
        <div className="flex gap-4 justify-center">
            <Button variant="outline" onClick={handleGenerateBossQuestion} disabled={isGenerating}>
                {isGenerating ? "Summoning Boss..." : "Generate Boss Question (AI)"}
            </Button>
            <Button onClick={handleNextQuestion}>Skip to Review</Button>
        </div>
      </div>
    );

    const question = questions[currentQuestionIndex];

    return (
      <div className="space-y-6 animate-in fade-in slide-in-from-right-8 duration-300">
         <div className="bg-gray-900 p-6 md:p-8 rounded-2xl border border-gray-800 shadow-xl min-h-[400px] flex flex-col">
            <div className="flex justify-between items-center mb-8">
              <span className="text-sm font-bold text-accent-400 uppercase tracking-wider">Question {currentQuestionIndex + 1} / {questions.length}</span>
              {question.id.startsWith('boss') && <span className="flex items-center text-xs text-purple-400"><BrainCircuit size={12} className="mr-1"/> AI Generated</span>}
            </div>

            <h3 className="text-xl md:text-2xl font-medium text-white mb-8 leading-snug">{question.text}</h3>

            <div className="space-y-3 flex-1">
              {question.options.map((opt, idx) => {
                let stateStyle = "bg-gray-800 border-gray-700 hover:bg-gray-750 hover:border-gray-600";
                if (isAnswerChecked) {
                  if (idx === question.correctIndex) stateStyle = "bg-brand-900/30 border-brand-500 text-brand-100";
                  else if (idx === selectedOption) stateStyle = "bg-red-900/30 border-red-500 text-red-100";
                  else stateStyle = "bg-gray-800 border-gray-700 opacity-50";
                } else if (selectedOption === idx) {
                  stateStyle = "bg-accent-900/20 border-accent-500 text-white shadow-md shadow-accent-900/10";
                }

                return (
                  <div 
                    key={idx}
                    onClick={() => handleAnswerSelect(idx)}
                    className={`p-4 rounded-lg border-2 cursor-pointer transition-all duration-200 ${stateStyle}`}
                  >
                    <div className="flex items-center">
                      <div className={`w-6 h-6 rounded-full border-2 mr-4 flex-shrink-0 flex items-center justify-center transition-colors
                        ${isAnswerChecked && idx === question.correctIndex ? 'border-brand-500 bg-brand-500' : 
                          selectedOption === idx ? 'border-accent-500' : 'border-gray-500'}
                      `}>
                        {isAnswerChecked && idx === question.correctIndex && <CheckCircle size={14} className="text-white" />}
                      </div>
                      <span className="text-base">{opt}</span>
                    </div>
                  </div>
                )
              })}
            </div>

            {isAnswerChecked && (
              <div className="mt-8 p-4 bg-gray-800/80 rounded-lg border-l-4 border-brand-500 animate-in fade-in">
                <p className="text-gray-300 text-sm leading-relaxed"><strong className="text-white block mb-1">Explanation:</strong> {question.explanation}</p>
              </div>
            )}

            <div className="mt-8 pt-4 border-t border-gray-800 flex flex-col gap-3">
              {!isAnswerChecked ? (
                <Button fullWidth size="lg" disabled={selectedOption === null} onClick={handleCheckAnswer}>Check Answer</Button>
              ) : (
                <>
                    <Button fullWidth size="lg" variant={currentQuestionIndex < questions.length - 1 ? "secondary" : "primary"} onClick={handleNextQuestion}>
                    {currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Practice'}
                    </Button>
                    
                    {!question.id.startsWith('boss') && (
                        <Button variant="ghost" className="text-purple-400 hover:text-purple-300" onClick={handleGenerateBossQuestion} disabled={isGenerating}>
                            <BrainCircuit size={16} className="mr-2" />
                            {isGenerating ? "Conjuring Boss..." : "Challenge Me (Boss Level)"}
                        </Button>
                    )}
                </>
              )}
            </div>
         </div>
      </div>
    );
  };

  const renderReview = () => (
     <div className="space-y-6 animate-in fade-in slide-in-from-right-8 duration-300">
      <div className="bg-gray-900 p-8 rounded-2xl border border-gray-800 shadow-xl text-center">
         <div className="bg-gray-800/50 rounded-full w-20 h-20 mx-auto flex items-center justify-center mb-6 ring-4 ring-gray-800">
            <Zap className="text-yellow-400 fill-yellow-400" size={32} />
         </div>

         <h3 className="text-2xl font-bold text-white mb-2">Great Focus!</h3>
         <p className="text-gray-400 mb-8 max-w-md mx-auto">You completed the questions. Take a deep breath. <br/>What is one thing you want to remember from today?</p>

         <textarea 
            className="w-full bg-gray-950 border border-gray-700 rounded-lg p-4 text-gray-200 focus:ring-2 focus:ring-brand-500 focus:border-transparent outline-none resize-none h-32 text-lg"
            placeholder="Type your key takeaway here..."
         ></textarea>

         <div className="mt-8">
           <Button fullWidth size="lg" onClick={handleReviewComplete}>Continue to Log</Button>
         </div>
      </div>
     </div>
  );

  const renderLog = () => (
    <div className="space-y-6 animate-in zoom-in duration-300">
      <div className="bg-gray-900 p-8 rounded-2xl border border-gray-800 shadow-2xl text-center max-w-md mx-auto">
         <h2 className="text-xl font-bold text-brand-400 uppercase tracking-wider mb-8">Session Log</h2>
         
         <div className="mb-8">
           <h3 className="text-lg text-white mb-4 font-medium">How confident do you feel about this topic?</h3>
           <div className="flex justify-between gap-2">
              {[1, 2, 3, 4, 5].map((num) => (
                <button
                  key={num}
                  onClick={() => setConfidenceRating(num)}
                  className={`w-12 h-12 rounded-xl font-bold text-lg transition-all transform
                    ${confidenceRating === num 
                      ? 'bg-brand-500 text-white ring-4 ring-brand-500/30 scale-110' 
                      : 'bg-gray-800 text-gray-400 hover:bg-gray-700 hover:text-white'}
                  `}
                >
                  {num}
                </button>
              ))}
           </div>
           <div className="flex justify-between text-xs text-gray-500 mt-2 px-1">
              <span>Unsure</span>
              <span>Master</span>
           </div>
         </div>

         <div className="mb-10">
           <h3 className="text-lg text-white mb-4 font-medium">How was your focus?</h3>
           <div className="flex justify-between gap-2">
              {[1, 2, 3, 4, 5].map((num) => (
                <button
                  key={num}
                  onClick={() => setEnergyRating(num)}
                  className={`w-12 h-12 rounded-xl font-bold text-lg transition-all transform
                    ${energyRating === num 
                      ? 'bg-accent-500 text-gray-900 ring-4 ring-accent-500/30 scale-110' 
                      : 'bg-gray-800 text-gray-400 hover:bg-gray-700 hover:text-white'}
                  `}
                >
                  {num}
                </button>
              ))}
           </div>
         </div>

         <Button fullWidth size="lg" disabled={confidenceRating === 0 || energyRating === 0} onClick={handleFinishSession}>
            Complete Session
         </Button>
      </div>
    </div>
  );

  return (
    <div className="min-h-screen flex flex-col max-w-2xl mx-auto px-4 py-6">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center space-x-4">
          <button 
             onClick={() => navigate('/')}
             className="p-2 hover:bg-gray-800 rounded-full text-gray-400 transition-colors"
             title="Exit Session"
          >
            <X size={24} />
          </button>
          <div>
             <h1 className="text-sm font-bold text-gray-300 uppercase tracking-widest flex items-center">
               ShadowFocus <span className="ml-2 w-2 h-2 rounded-full bg-red-500 animate-pulse"></span>
             </h1>
             <p className="text-xs text-gray-600">
                                                {duration ? duration + " min session" : "Distraction Free"}
             </p>
          </div>
        </div>
      </div>

      {renderPhaseIndicator()}

      <div className="flex-1 flex flex-col justify-center pb-12">
        {phase === SessionPhase.BUILD && renderBuild()}
        {phase === SessionPhase.PRACTICE && renderPractice()}
        {phase === SessionPhase.REVIEW && renderReview()}
        {phase === SessionPhase.LOG && renderLog()}
      </div>
    </div>
  );
};

export default Session;

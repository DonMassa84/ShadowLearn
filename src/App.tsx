import React from 'react';
import { HashRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Layout from './components/Layout';
import Dashboard from './pages/Dashboard';
import CourseMap from './pages/CourseMap';
import Session from './pages/Session';
import Flashcards from './pages/Flashcards';
import PassiveMode from './pages/PassiveMode';

// Placeholder components
const Stats = () => (
  <div className="flex flex-col items-center justify-center h-full text-center p-8 animate-in fade-in">
    <h1 className="text-3xl font-bold text-white mb-4">Statistics</h1>
    <p className="text-gray-400 max-w-md">
      Detailed analytics and learning insights will appear here. 
      Track your progress across Part A, B, and D of the IHK curriculum.
    </p>
  </div>
);

const Settings = () => (
  <div className="flex flex-col items-center justify-center h-full text-center p-8 animate-in fade-in">
    <h1 className="text-3xl font-bold text-white mb-4">Settings</h1>
    <p className="text-gray-400 max-w-md">
      Configure your learning preferences, notification settings, and API connections here.
    </p>
  </div>
);

const App: React.FC = () => {
  return (
    <Router>
      <Layout>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/map" element={<CourseMap />} />
          <Route path="/flashcards" element={<Flashcards />} />
          <Route path="/passive" element={<PassiveMode />} />
          <Route path="/stats" element={<Stats />} />
          <Route path="/settings" element={<Settings />} />
          <Route path="/session/:dayId" element={<Session />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Layout>
    </Router>
  );
};

export default App;

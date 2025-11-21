import React from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { LayoutDashboard, Map, User, Settings, Zap, Layers, Headphones } from 'lucide-react';

interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  const location = useLocation();
  const isSessionMode = location.pathname.startsWith('/session/');

  if (isSessionMode) {
    return <div className="h-full w-full bg-gray-950">{children}</div>;
  }

  const navItems = [
    { path: '/', icon: LayoutDashboard, label: 'Home' },
    { path: '/map', icon: Map, label: 'Plan' },
    { path: '/flashcards', icon: Layers, label: 'Cards' },
    { path: '/passive', icon: Headphones, label: 'Passive' },
    { path: '/stats', icon: User, label: 'Profile' },
    { path: '/settings', icon: Settings, label: 'Settings' },
  ];

  return (
    <div className="flex h-screen bg-gray-950 text-gray-100 overflow-hidden">
      <div className="md:hidden fixed bottom-0 left-0 right-0 bg-gray-900 border-t border-gray-800 z-50 pb-safe">
        <div className="flex justify-around items-center h-16 px-2">
          {navItems.slice(0, 5).map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) =>
                `flex flex-col items-center justify-center w-full h-full space-y-1 ${
                  isActive ? 'text-brand-400' : 'text-gray-500 hover:text-gray-300'
                }`
              }
            >
              <item.icon size={20} />
              <span className="text-[10px] font-medium">{item.label}</span>
            </NavLink>
          ))}
        </div>
      </div>

      <aside className="hidden md:flex flex-col w-64 bg-gray-900 border-r border-gray-800 h-full">
        <div className="p-6 flex items-center space-x-3">
          <div className="bg-brand-500/10 p-2 rounded-lg">
            <Zap className="text-brand-500" size={24} />
          </div>
          <span className="text-xl font-bold tracking-tight">ShadowFocus</span>
        </div>
        
        <nav className="flex-1 px-4 space-y-2 mt-4">
          {navItems.map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) =>
                `flex items-center space-x-3 px-4 py-3 rounded-lg transition-colors ${
                  isActive 
                    ? 'bg-gray-800 text-brand-400 border-l-4 border-brand-400' 
                    : 'text-gray-400 hover:bg-gray-800/50 hover:text-gray-100'
                }`
              }
            >
              <item.icon size={20} />
              <span className="font-medium">{item.label}</span>
            </NavLink>
          ))}
        </nav>
      </aside>

      <main className="flex-1 h-full overflow-y-auto overflow-x-hidden pb-20 md:pb-0 relative">
        <div className="max-w-4xl mx-auto p-4 md:p-8">
          {children}
        </div>
      </main>
    </div>
  );
};

export default Layout;

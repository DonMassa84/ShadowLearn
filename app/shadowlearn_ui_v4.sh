#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app/src/app"

mkdir -p "$APP/animated"
mkdir -p "$APP/components"
mkdir -p "$APP/views"

###########################
# 1. Animated Flashcard View
###########################
cat << 'EOC' > "$APP/animated/AnimatedFlashcardView.tsx"
import React from "react";
import { motion } from "framer-motion";

export default function AnimatedFlashcardView({ card }) {
  if (!card) return <div className="text-slate-500">Keine Karte geladen.</div>;

  return (
    <motion.div
      key={card.id}
      initial={{ opacity: 0, y: 30, scale: 0.95 }}
      animate={{ opacity: 1, y: 0, scale: 1 }}
      exit={{ opacity: 0, y: -30, scale: 0.95 }}
      transition={{ duration: 0.35 }}
      className="bg-slate-800 p-6 rounded-2xl shadow-xl border border-slate-700"
    >
      <div className="text-lg font-bold text-cyan-300 mb-4">{card.prompt}</div>
      <div className="text-slate-200">{card.answer}</div>
    </motion.div>
  );
}
EOC

##################################
# 2. Animated Topics View
##################################
cat << 'EOC' > "$APP/animated/AnimatedTopicsView.tsx"
import React from "react";
import { motion } from "framer-motion";
import { Link } from "react-router-dom";

export default function AnimatedTopicsView({ topics }) {
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.4 }}
      className="p-6"
    >
      <h1 className="text-xl font-bold text-cyan-300 mb-4">Themen</h1>
      <div className="grid gap-4">
        {topics.map((t, i) => (
          <motion.div
            key={t.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.05 }}
          >
            <Link
              to={"/topics/" + t.id}
              className="block bg-slate-800 rounded-xl p-4 border border-slate-700 hover:bg-slate-700 transition"
            >
              {t.title}
            </Link>
          </motion.div>
        ))}
      </div>
    </motion.div>
  );
}
EOC

######################################
# 3. Animated Deck Selection View
######################################
cat << 'EOC' > "$APP/animated/AnimatedDecksView.tsx"
import React from "react";
import { motion } from "framer-motion";
import { Link } from "react-router-dom";

export default function AnimatedDecksView({ decks }) {
  return (
    <motion.div
      className="p-6"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
    >
      <h1 className="text-xl font-bold text-cyan-300 mb-4">Decks</h1>
      <div className="grid gap-4">
        {decks.map((d, i) => (
          <motion.div
            key={d.id}
            initial={{ opacity: 0, x: -30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: i * 0.05 }}
          >
            <Link
              to={"/learn/" + d.id}
              className="block bg-slate-800 p-4 rounded-xl hover:bg-slate-700 border border-slate-700"
            >
              {d.title}
            </Link>
          </motion.div>
        ))}
      </div>
    </motion.div>
  );
}
EOC

########################################
# 4. Animated Page Layout
########################################
cat << 'EOC' > "$APP/animated/AnimatedLayout.tsx"
import React from "react";
import { motion } from "framer-motion";

export default function AnimatedLayout({ children }) {
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.25 }}
      className="min-h-screen flex justify-center p-6 bg-slate-900 text-slate-200"
    >
      <div className="w-full max-w-2xl">{children}</div>
    </motion.div>
  );
}
EOC

########################################
# 5. Animated NavigationBar
########################################
cat << 'EOC' > "$APP/components/AnimatedNavigationBar.tsx"
import React from "react";
import { Link, useLocation } from "react-router-dom";
import { motion } from "framer-motion";

export default function AnimatedNavigationBar() {
  const loc = useLocation();
  const active = (p) =>
    loc.pathname.startsWith(p)
      ? "text-cyan-300"
      : "text-slate-400 hover:text-slate-200";

  return (
    <motion.div
      initial={{ opacity: 0, y: -10 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
      className="w-full flex justify-center py-4 bg-slate-800 shadow-lg border-b border-slate-700"
    >
      <div className="flex gap-6 text-lg">
        <Link className={active("/learn")} to="/learn">Lernen</Link>
        <Link className={active("/topics")} to="/topics">Themen</Link>
        <Link className={active("/decks")} to="/decks">Decks</Link>
      </div>
    </motion.div>
  );
}
EOC

echo "[✓] ShadowLearn v4 UI + Animation Suite installiert."

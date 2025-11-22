import { BrowserRouter, Routes, Route } from "react-router-dom";
import LearnView from "../views/LearnView";
import TopicsView from "../views/TopicsView";
import DecksView from "../views/DecksView";
import ImporterView from "../views/ImporterView";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LearnView />} />
        <Route path="/learn" element={<LearnView />} />
        <Route path="/topics" element={<TopicsView />} />
        <Route path="/decks" element={<DecksView />} />
        <Route path="/import" element={<ImporterView />} />
      </Routes>
    </BrowserRouter>
  );
}

// A* Planner — connection settings.
// Paste the two values from your Supabase project: Project Settings → API.
// Both are safe to publish: the anon key only allows what the database rules permit,
// and the rules only let each signed-in person read and write their own grades.
window.PLANNER_CONFIG = {
  supabaseUrl: "https://YOUR-PROJECT-ID.supabase.co",
  supabaseAnonKey: "YOUR-ANON-PUBLIC-KEY"
};

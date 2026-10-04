// A* Planner — connection settings.
// These two values come from the Supabase project (Project Settings → API).
// Both are safe to publish: the anon key only allows what the database rules permit,
// and the rules only let each signed-in person read and write their own grades.
window.PLANNER_CONFIG = {
  supabaseUrl: "https://fdjcufvtjkpyrbodkyfj.supabase.co",
  supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZkamN1ZnZ0amtweXJib2RreWZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTExMjYwMjgsImV4cCI6MjEwNjcwMjAyOH0.1O5CwLQkI2nhKxwg7TgP18l9up54xP-p9V4_gfXB52Y"
};

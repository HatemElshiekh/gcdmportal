# Digital Marketing Plan Live Dashboards

This package is ready to upload to GitHub Pages.

## Files

- `index.html` — overview page linking both phases.
- `phase-1.html` — Phase 1 editable dashboard.
- `phase-2.html` — Phase 2 editable dashboard.
- `config.js` — add your Supabase Project URL and anon/public key here.
- `supabase-setup.sql` — run this once in Supabase SQL Editor.

## Setup

1. Create a Supabase project.
2. Open Supabase SQL Editor and run `supabase-setup.sql`.
3. In Supabase, go to Project Settings > API.
4. Copy the Project URL and anon/public key.
5. Paste both values into `config.js`.
6. Upload all files to the root of a GitHub repository.
7. In GitHub, go to Settings > Pages.
8. Set source to Deploy from branch, branch `main`, folder `/root`.
9. Open the published GitHub Pages URL.

## How shared saving works

- Clicking text and blurring the field saves the current dashboard state to Supabase.
- Dragging KPI rows saves the new order to Supabase.
- Everyone viewing the same URL receives updates through Supabase Realtime.
- Export JSON still works as a manual backup.
- Reset edits resets the phase for everyone.

## Security note

This version has no password or login because it is intended for a private manager link. Anyone with the URL and the public Supabase key can edit the two dashboard records. Do not use this no-login setup for sensitive public distribution.

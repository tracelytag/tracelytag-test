TracelyTag Final - Web + API combined for Render (NET 8)
------------------------------------------------------
This is a ready-to-upload repository that contains both TracelyTagAPI and TracelyTagWeb projects and a Dockerfile at the repository root.
How to use:
  1. Upload this folder to a new GitHub repository (or push from local).
  2. On Render: New -> Web Service -> Connect GitHub -> select the repo -> Environment: Docker -> Port: 8080.
  3. Deploy. Render will build and run the Web project detected automatically.
Notes:
  - If Render build fails saying it can't find the csproj, open the repo and confirm which .csproj is the Web project and update Dockerfile accordingly.
  - For better architecture later, deploy API as a separate service and set Web's API base URL to that service URL.

---
name: git-tag
description: Tag the project after completing an implementation milestone. Use after finishing a feature, component, or build milestone.
argument-hint: "[version] [message]"
---

Tag the current commit to mark a completed implementation milestone.

## Steps

1. **Determine the tag name:**
   - If `$ARGUMENTS` is provided, use it as the tag (e.g. `v0.1.0`, `v0.2`).
   - If no argument is given, read the current version from `simple_design/pubspec.yaml` and use `v{version}` as the tag name.

2. **Check for existing tags** to avoid duplicates:
   ```bash
   git tag --list
   ```
   If the tag already exists, append a build number suffix like `-1`, `-2`, etc.

3. **Create an annotated tag:**
   ```bash
   git tag -a <tag-name> -m "<message>"
   ```
   - If a message is given as the second argument, use it.
   - Otherwise, auto-generate a message in this format:
     `"Release <tag-name> — <brief summary of what was implemented based on recent commits>"`
   - To get recent commits for the summary:
     ```bash
     git log --oneline -10
     ```

4. **Confirm success** by running:
   ```bash
   git tag --list --sort=-version:refname | head -5
   ```

5. **Report to the user:**
   - Tag name created
   - Commit it points to (`git rev-parse --short HEAD`)
   - Full tag message
   - Remind the user to push the tag when ready: `git push origin <tag-name>`

## Rules
- Always use **annotated tags** (`git tag -a`), never lightweight tags.
- Never push automatically — only create the local tag and remind the user to push.
- Follow semantic versioning: `v{major}.{minor}.{patch}` (e.g. `v0.1.0`).
- Milestone tags from `CLAUDE.md` map to versions: v0.1 Foundation → `v0.1.0`, v0.2 Forms → `v0.2.0`, etc.
- Do not put Co-Authored-By:, no exceptions
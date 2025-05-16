# Blog Upgrade Plan: Styling and Deployment to GitHub Pages

This document outlines the plan to update the styling of the Hugo-based personal blog and migrate its deployment from AWS S3 to GitHub Pages.

## Chosen Theme
- **PaperMod**: [https://github.com/adityatelange/hugo-PaperMod](https://github.com/adityatelange/hugo-PaperMod)

## Phases and Steps

**Phase 1: Theme Update & Local Configuration**
1.  **Theme Selection:** PaperMod (Chosen)
2.  **Local Theme Integration:** Add PaperMod as a Git submodule and update `config.toml`.
3.  **Content & Styling Adjustments:** Preview locally using `hugo server`, verify existing blog posts, and make any minor styling tweaks or content adjustments to fit the new theme.
4.  **Update BaseURL:** Adjust the `baseurl` in `config.toml` to reflect the future GitHub Pages URL (e.g., `https://<your-username>.github.io/<repository-name>/` or `https://<your-username>.github.io/`).

**Phase 2: GitHub Pages Deployment**
5.  **Create GitHub Repository:** Create a new public GitHub repository for the blog.
6.  **GitHub Actions Workflow:** Create a GitHub Actions workflow file (e.g., `.github/workflows/deploy.yml`). This workflow will automatically:
    *   Checkout the code.
    *   Set up Hugo.
    *   Build the Hugo site into the `public/` directory.
    *   Deploy the contents of `public/` to the `gh-pages` branch (or `main` branch for user/org sites).
7.  **Remove Old Deployment Configuration:**
    *   Delete the AWS deployment section from `config.toml`.
    *   Delete the old `deploy.sh` script.
8.  **Commit & Push:** Commit all changes (new theme files, updated `config.toml`, new GitHub Actions workflow, deleted files) and push to the new GitHub repository.

**Phase 3: Verification & Future Custom Domain**
9.  **Verify Deployment:** Check the GitHub Actions tab in the repository to ensure the deployment workflow ran successfully. Access the blog at the new GitHub Pages URL to confirm it's live and looks as expected.
10. **Custom Domain (Future Task):** When ready to use `blog.coze.org` again:
    *   Configure the custom domain in the GitHub repository settings.
    *   Update DNS records (CNAME or A records) to point to GitHub Pages.
    *   Update the `baseurl` in `config.toml` back to `https://blog.coze.org/`.

## Plan Overview (Mermaid Diagram)

```mermaid
graph TD
    A[Start: Update Blog] --> B{Phase 1: Theme & Local Setup};
    B --> B1[Theme: PaperMod];
    B1 --> B2[Integrate Theme Locally (Git Submodule)];
    B2 --> B3[Update config.toml: theme, baseurl];
    B3 --> B4[Verify Content & Styling Locally (hugo server)];

    B4 --> C{Phase 2: GitHub Pages Deployment};
    C --> C1[Create GitHub Repository];
    C1 --> C2[Create GitHub Actions Workflow for Hugo Deployment];
    C2 --> C3[Remove Old AWS Deployment Config & Script];
    C3 --> C4[Commit & Push Changes to GitHub];

    C4 --> D{Phase 3: Verification & Future};
    D --> D1[Verify Site on GitHub Pages URL];
    D1 --> D2[Future: Configure Custom Domain blog.coze.org];
    D2 --> E[End: Blog Updated & Deployed];
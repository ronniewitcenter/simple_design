---
name: github-docs-formatter
description: Formats, organizes, and structures GitHub Markdown documentation according to Diátaxis and best practices. Use whenever the user asks to format a markdown file, create a README, or organize repository documentation.
---

# Organizing Markdown Documentation in GitHub

The proper way to organize your Markdown documentation in GitHub involves a combination of logical folder structure, a comprehensive root `README.md` file, and using a consistent writing style. For more extensive documentation, consider leveraging GitHub Pages to publish your Markdown files as a clean, structured website.

## Folder and File Structure

* **`README.md` in the Root:** Every project should have a `README.md` file in the root directory. This file serves as the main entry point and should provide a high-level overview, installation instructions, and links to more detailed documentation.
* **Dedicated `docs` Directory:** For detailed, multi-page documentation, create a top-level `docs` directory.
* **Logical Grouping:** Within the `docs` folder, group related content into subdirectories. The Diátaxis framework recommends categories based on purpose:
    * `tutorials/`: Learning-oriented, step-by-step instructions for beginners.
    * `how-to-guides/` or `howto/`: Goal-oriented directions for specific tasks or problems.
    * `explanation/`: Understanding-oriented discussions that deepen knowledge.
    * `reference/`: Information-oriented technical descriptions (e.g., API documentation).
* **Consistent Naming:** Use concise, descriptive filenames in lowercase, separated by hyphens (e.g., `quick-start-guide.md`).
* **`index.md` Files:** Include an `index.md` file in each folder to provide an overview and navigation links to other pages within that section.
* **`CONTRIBUTING.md`:** Place a `CONTRIBUTING.md` file in the root or a `.github` folder to provide guidelines for potential contributors.

## Writing and Formatting Best Practices

* **Clarity and Conciseness:** Use plain, easy-to-understand language and an active voice. Avoid jargon when possible.
* **Scannability:** Structure documents for readers who scan rather than read every word.
    * Use meaningful headings (`#`, `##`, `###`) to create a clear hierarchy. GitHub automatically generates a table of contents from these headings in the rendered view.
    * Utilize formatting elements like bulleted lists, numbered lists, and tables.
    * Use text highlighting (**boldface**, hyperlinks) sparingly for emphasis.
* **Link to Relevant Information:** Embed markdown links to related documents, external resources, or specific code sections to provide context and improve navigation.
* **Visual Aids:** Enhance clarity with images, diagrams, or code blocks where appropriate.
* **Use Templates:** Develop and use consistent documentation templates for different types of documents (e.g., new feature guide, API reference) to ensure uniformity across the repository.

## Advanced Organization

For a more professional and navigable experience, consider the following:

* **GitHub Pages:** Host your documentation as a dedicated website using GitHub Pages. This allows for a more polished look than plain Markdown files in a repository.
* **External Tools:** Use static site generators like MkDocs or Docusaurus with your `docs` folder to create a full documentation website.
* **Automated TOC:** Tools like the "Markdown All in One" extension for Visual Studio Code can help generate and manage tables of contents for individual files.
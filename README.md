## Setup

### Build Site
`nix build .`

### Start Dev Server

`nix run .#develop`

### Generate mermaid docs

`mmdc -i docs/mermaid.mmd -o static/images/mermaid.svg`

### TODO

- [x] Add Workflow
- [x] Cleanup code
- [x] Add dynamic paths and file reads for blog
- [x] Add markdown/djot parsing (maybe Pandoc)
- [x] Move all images to static image dir
- [x] Add custom djot renderer
- [x] Add custom lustre component support via vite
- [x] Add Projects Page
- [x] Add Tags
- [x] Fix meta tags, they should be different per page
- [x] Deprecate Google Fonts
- [x] Add copy button
- [x] Add syntax highlighter
- [x] Add custom code block
- [x] Add SEO attributes and images for embeds
- [x] Add date sorting
- [x] Add Shiki diff highlighting
- [x] Replace shoelace with [grille-pain](https://github.com/ghivert/grille-pain)
- [x] Switch components from building with vite to esgleam
- [x] Add mermaid support
- [x] Setup blog source code section
- [x] Move dirs to env
- [x] Add tag filters
- [x] Add giscus
- [x] Minify esgleam generated js
- [x] Add support for custom Lustre elements like for example: callout, source code buttons etc.
- [x] Add callout component
- [x] Fix Project page mobile layout
- [ ] Fixup env stuff, inject with workflow so I can remove from flake
- [ ] Migrate from vite to custom gleam serve script
- [ ] Migrate from shiki script to gleam implementation (in build.gleam) that maps to shiki (maybe use chic)
- [x] Add classname func
- [x] Pre-gen mermaid docs
- [ ] Add dark mode

### Credit

Thanks to [Olle](https://github.com/ollema) for the awesome code highlighting tool [Glimra](https://github.com/ollema/glimra) and the examples I used in this blog

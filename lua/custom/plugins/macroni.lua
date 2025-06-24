return {
  'jesseleite/nvim-macroni',
  lazy = false,
  opts = {
    macros = {
      guide_tip_mdx = {
        macro = 'ddO<lt>Callout><Esc>jV/:::<CR>k>/:::<CR>ddO<lt>/Callout><Esc>',
        desc = 'guide change :::tip syntax to <Callout>',
      },
      guide_docs_link = {
        macro = 'vf"<Ignore>c`<Esc>f:<Ignore>xdwf"<Ignore>r`<Ignore>lvf><Ignore>d',
        desc = 'guide replace docslink with inline code block',
      },
    },
    -- All of your `setup(opts)` and saved macros will go here
  },
}

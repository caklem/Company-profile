// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  output: 'static',
  build: {
    inlineStylesheets: 'auto'
  },
  compressHTML: true,
  site: 'https://your-domain.com', // Ganti dengan domain Anda
  base: '/'
});

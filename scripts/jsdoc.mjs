#!/usr/bin/env node

import { promises as fs } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.resolve(path.dirname(__filename), '..');

const interfacePath = path.join(__dirname, 'nrlmsise_interface.cpp');
const indexPath = path.join(__dirname, 'bin', 'index.mjs');

async function generateJSDoc() {
  const cpp = await fs.readFile(interfacePath, 'utf8');
  const classMatch = cpp.match(/class\s+(\w+)/);
  if (!classMatch) throw new Error('Class definition not found in C++ source');
  const className = classMatch[1];

  const props = Array.from(
    cpp.matchAll(/\.property\("(\w+)",/g)
  ).map(m => m[1]);

  const jsdoc = [
    '/**',
    ` * @class ${className}`,
    ' * @classdesc WASM-bound class for NRLMSISE-00 model',
    ...props.map(p => ` * @property {number} ${p}`),
    ' */',
    ''
  ].join('\n');

  let indexSrc = await fs.readFile(indexPath, 'utf8');
  indexSrc = indexSrc.replace(
    /(var\s+nrlmsiseModule\s*=)/,
    `${jsdoc}\n$1`
  );

  await fs.writeFile(indexPath, indexSrc, 'utf8');
}

generateJSDoc().catch(err => {
  console.error(err);
  process.exit(1);
});

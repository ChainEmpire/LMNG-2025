const fs = require('fs');
const path = require('path');

const outputFile = 'file_list.txt';
const baseDir = process.cwd();
let result = [];

function listFilesRecursive(dir) {
  const files = fs.readdirSync(dir);

  for (const file of files) {
    const fullPath = path.join(dir, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      listFilesRecursive(fullPath);
    } else {
      const relativePath = path.relative(baseDir, fullPath);
      result.push(relativePath);
    }
  }
}

listFilesRecursive(baseDir);

// Write relative paths to file
fs.writeFileSync(outputFile, result.join('\n'), 'utf-8');
console.log(`Saved ${result.length} relative file paths to ${outputFile}`);

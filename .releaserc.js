const path = require('path');

/** Detect current branch from env */
const branch = process.env.GITHUB_REF?.replace('refs/heads/', '') || process.env.CI_COMMIT_REF_NAME;

const isMain = branch === 'main';

module.exports = {
  branches: [
    'dev',
    {
      name: 'main',
      channel: 'latest',
      range: '*'
    }
  ],
  tagFormat: 'v${version}',
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    [
      '@semantic-release/npm',
      {
        npmPublish: false,
        pkgRoot: 'frontend'
      }
    ],
    ...(isMain
      ? [[
          '@semantic-release/github',
          {
            assets: [{ path: 'frontend/dist', label: 'Build output' }]
          }
        ]]
      : [])
  ]
};


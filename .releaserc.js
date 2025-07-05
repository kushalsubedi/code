const path = require('path');

const branch = process.env.GITHUB_REF?.replace('refs/heads/', '') || process.env.CI_COMMIT_REF_NAME;

const isMain = branch === 'main';

module.exports = {
  branches: [
    {
      name: 'dev',
      prerelease: true // allows any prerelease version on dev, no range limits
    },
    {
      name: 'main',
      channel: 'latest',
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


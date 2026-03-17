import type { Config } from 'jest';

const config: Config = {
  clearMocks: true,
  collectCoverageFrom: ['src/**/*.ts', '!src/**/*.d.ts', '!src/**/__tests__/**'],
  coverageDirectory: 'coverage',
  moduleFileExtensions: ['ts', 'js', 'json'],
  rootDir: '.',
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.test.ts', '**/?(*.)+(spec|test).ts'],
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        isolatedModules: true,
        tsconfig: {
          module: 'commonjs'
        }
      }
    ]
  }
};

export default config;

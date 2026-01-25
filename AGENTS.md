# Agent Guide

This repository contains the source code for OpenCode, an AI-powered development tool.

## Project Structure

- `packages/opencode`: The core CLI and backend logic (Bun, Hono, AI SDK).
- `packages/app`: The frontend application (SolidJS, Vite, Playwright).
- `packages/sdk`: SDKs for interacting with OpenCode.
- `infra`: Infrastructure code (SST).

## Build, Lint, and Test

**IMPORTANT**: Do not run tests from the root directory. Run them within the specific package.

### `packages/opencode` (CLI/Backend)

- **Build**: `bun run script/build.ts`
- **Test**: `bun test`
  - **Single Test**: `bun test test/path/to/test.ts`
- **Lint**: `bun run lint` (runs tests with coverage)
- **Format**: `bun run format` (Prettier)

### `packages/app` (Frontend)

- **Build**: `bun run build` (Vite)
- **Test (E2E)**: `bun run test` (Playwright)
- **Dev**: `bun run dev`

### General

- **Typecheck**: `bun run typecheck` (uses Turbo)
- **Format**: `bun run prettier --write .`

## Code Style & Conventions

Strictly adhere to `STYLE_GUIDE.md`:

1.  **Variables**:
    - Avoid `let`. Use `const`.
    - Avoid `else`. Use early returns or IIFEs.
    - **Naming**: Prefer single-word names (`const foo` not `const fooBar`).
2.  **Destructuring**:
    - **AVOID** destructuring. Use `obj.a` instead of `const { a } = obj` to preserve context.
3.  **APIs**:
    - Use **Bun APIs** whenever possible (e.g., `Bun.file()`, `Bun.write()`) instead of Node `fs`.
4.  **Error Handling**:
    - Avoid `try/catch` blocks where possible.
5.  **Types**:
    - Avoid `any`.
    - Use `interface` for object definitions.
    - Zod is used for validation.

## Agent Behavior Rules

1.  **Parallelism**: ALWAYS use parallel tools when applicable (e.g., `ls` and `grep` together).
2.  **Paths**: Use **ABSOLUTE PATHS** for all file operations.
3.  **Context**: Read `package.json` in the specific package you are working on to check for available scripts and dependencies.
4.  **Testing**:
    - When modifying `packages/opencode`, run related tests using `bun test`.
    - When modifying `packages/app`, consider running E2E tests if UI flows are changed.
5.  **Proactiveness**: If you modify code, verify it by running the build or tests.

## Specific Package Details

### `packages/opencode`

- This is a **Bun** application.
- Uses `@ai-sdk/*` for AI capabilities.
- Uses `hono` for the server framework.
- Entry point: `src/index.ts`.
- Bin: `bin/opencode`.

### `packages/app`

- This is a **SolidJS** application.
- Uses `vite` for building.
- Uses `tailwindcss` for styling.
- Uses `playwright` for testing.

Instructions from: /Users/vulcanlabs/Documents/demo/opencode/STYLE_GUIDE.md

## Style Guide

- Keep things in one function unless composable or reusable
- Avoid unnecessary destructuring. Instead of `const { a, b } = obj`, use `obj.a` and `obj.b` to preserve context
- Avoid `try`/`catch` where possible
- Avoid using the `any` type
- Prefer single word variable names where possible
- Use Bun APIs when possible, like `Bun.file()`

# Avoid let statements

We don't like `let` statements, especially combined with if/else statements.
Prefer `const`.

Good:

```ts
const foo = condition ? 1 : 2
```

Bad:

```ts
let foo

if (condition) foo = 1
else foo = 2
```

# Avoid else statements

Prefer early returns or using an `iife` to avoid else statements.

Good:

```ts
function foo() {
  if (condition) return 1
  return 2
}
```

Bad:

```ts
function foo() {
  if (condition) return 1
  else return 2
}
```

# Prefer single word naming

Try your best to find a single word name for your variables, functions, etc.
Only use multiple words if you cannot.

Good:

```ts
const foo = 1
const bar = 2
const baz = 3
```

Bad:

```ts
const fooBar = 1
const barBaz = 2
const bazFoo = 3
```

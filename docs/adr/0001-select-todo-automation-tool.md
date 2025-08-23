# ADR 0001: Choice of Tool for Automatic Issue Creation from Code Comments

| **Status:**       | Accepted        |
| :---------------- | :-------------- |
| **Participants:** | Anton Stupenkov |
| **Date:**         | 2025-08-23      |
| **Related ADRs:** | —               |

## Context

During the development process, developers frequently leave reminder comments in the code (e.g., `// TODO: Refactor this method`). To ensure these notes are captured and converted into proper tracker issues, a tool is required to automatically collect them and create issues.

**Requirement:** New TODOs must be discovered **immediately after they are merged into the main branch**.

Two candidates are considered:

1. **[`todo-to-issue-action`](https://github.com/alstr/todo-to-issue-action)** — an open-source GitHub Action.
2. **[`0pdd`](https://www.0pdd.com)** — an external SaaS service specializing in automatic TODO tracking.

Other potential solutions (self-written scripts or alternative SaaS) were not considered due to lack of immediate trigger support or insufficient community adoption.

---

## Decision Drivers

* **Operational Efficiency:** Automatic and immediate creation of issues after PR merges.
* **Security:** Minimize third-party access permissions.
* **Control and Transparency:** Ability to debug, customize, and monitor the process.
* **Maintainability:** Prefer solutions integrated into our existing ecosystem (GitHub) rather than external dependencies.
* **Cost:** Minimize additional costs and avoid unnecessary consumption of GitHub Actions minutes.

---

## Considered Options

| Feature / Driver       | `todo-to-issue-action`                          | `0pdd`                              |
| ---------------------- | ----------------------------------------------- | ----------------------------------- |
| Immediate Execution    | ✅ Yes, triggers on push/PR merge                | ⚠️ Polling, delay possible          |
| Security / Permissions | ✅ Minimal (GitHub Actions token)                | ⚠️ Full repo access required        |
| Customization          | ✅ Full control (custom tags, workflow triggers) | ⚠️ Limited to service functionality |
| Transparency / Logs    | ✅ Logs in GitHub Actions                        | ⚠️ Logs hidden in external service  |
| Setup Complexity       | ⚠️ Requires workflow YAML                       | ✅ Very simple (connect & go)        |
| Cost                   | ✅ Free within GitHub Actions limits             | ✅ Free                              |

---

### Option 1: GitHub Action `todo-to-issue-action`

* **Description:** Runs inside GitHub Actions and can be triggered on `push` or `pull_request` events.
* **Pros:**

  * Full control and configurability.
  * Immediate reaction after merge.
  * Works natively in GitHub ecosystem.
  * Free for public repositories.
  * Transparent logs in GitHub Actions.
* **Cons:**

  * Requires workflow setup.
  * Uses GitHub Actions minutes.
  * Maintenance of updates if customized.

---

### Option 2: External Service `0pdd`

* **Description:** SaaS service monitoring commits and creating issues automatically.
* **Pros:**

  * Minimal setup.
  * Runs externally, no Actions minutes consumed.
* **Cons:**

  * Potential delays due to polling.
  * Requires full repository access.
  * Vendor lock-in; future availability uncertain.
  * Limited customization.
  * Logs and diagnostics hidden.

---

## Decision

**Chosen Option:** 1 — `todo-to-issue-action`.

**Justification:**

* **Operational Efficiency:** Immediate execution guaranteed on merge to main branch.
* **Security:** Avoids granting broad access to external SaaS.
* **Control and Transparency:** Full visibility, customization, and long-term stability outweigh setup simplicity of `0pdd`.
* **Predictability:** We own the process and logs, reducing operational risk.

---

## Consequences

* GitHub Actions minutes are consumed on each push to `main` (negligible for typical usage).
* Maintenance responsibility: we must monitor Action updates.
* Process monitoring and testing should be implemented to ensure no TODOs are missed and duplicates are avoided.
* We gain precise control, immediate feedback, and independence from external vendors.

---

## Appendix: Recommended Configuration

`.github/workflows/todo-to-issue.yml`

```yaml
name: 'Scan for TODOs on Main Branch'
on:
  push:
    branches: [ main ] # Trigger on push to main branch
jobs:
  scan-todos:
    runs-on: ubuntu-latest
    # Skip runs triggered by this Action itself
    if: github.event.head_commit.message != 'TODO to Issue Action'
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 0 # Full history needed for diffing
    - name: Run TODO to Issue Action
      uses: alstr/todo-to-issue-action@v4
      with:
        assignee: author
        label: todo
        exclude: '**/node_modules/**,**/vendor/**'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Notes:**

* Monitor upstream releases of `todo-to-issue-action` for updates.
* Implement a test or validation step to ensure newly created issues match TODOs and no duplicates are generated.
* Optionally, a fallback cron schedule can be kept as a backup trigger.

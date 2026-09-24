# AGENTS.md

This repository contains the snap packaging (and colocated YARF UI tests) for
the **fresh-editor** snap, published by kenvandine.

## Automated maintenance

This repository is maintained in part by the `automated-ken` fleet-maintenance
system (https://github.com/kenvandine/automated-ken). Automated agents may:

- Open pull requests bumping the packaged application/runtime version
- Queue YARF UI test runs on a registered remote runner (real hardware polling the
  automated-ken dashboard for jobs) against candidate/edge builds before promoting a
  release
- Review and comment on PRs, including AI-assisted screenshot review of UI test
  results

## Tests

YARF UI test suites belong under `tests/suite/` in this repository. They are
executed by a registered remote runner (physical/real hardware enrolled with the
automated-ken dashboard), which polls the dashboard for queued jobs, downloads/
installs the target snap build, runs the YARF suite locally, and uploads
screenshots/results directly back to the dashboard. No GitHub Actions workflow is
involved in running tests.

## Conventions

- Do not remove the `tests/suite/` directory; it is required for automated release
  validation. There is no test-running GitHub Actions workflow in this repo by
  design — tests run on a registered remote runner.
- Redundant upstream-polling / sync-release workflows that duplicate automated-ken's
  own version-bump automation should be removed to avoid conflicting/duplicate PRs.

## Upstream release detection

Upstream is `sinelaw/fresh` on GitHub, and this repo's `source:` already
points directly at `https://github.com/sinelaw/fresh.git`, so
automated-ken's generic GitHub upstream checker
(`snap_dashboard.snapcraft.upstream.get_latest_version` /
`_github_latest`) already handles this snap correctly:

- It queries `https://api.github.com/repos/sinelaw/fresh/releases/latest`
  (falls back to the most recent tag if there is no release), which
  already excludes drafts/prereleases.
- The version is the release's `tag_name` with a leading `v` stripped
  (e.g. tag `v0.5.1` → version `0.5.1`).
- Compare against the top-level `version:` field in `snap/snapcraft.yaml`
  and update it directly if different — no `craftctl`/`source-tag`
  involved for this snap.

No custom logic is required here; this note exists so agents don't need
to re-derive it from the now-removed `sync-release.yml` workflow.

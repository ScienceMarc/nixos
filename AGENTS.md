
# NixOS Configuration Guidelines

- This repository contains my personal NixOS configuration.
- Prefer small, targeted changes over broad refactoring.
- Follow the existing module organization and coding style.
- Check whether settings are managed by NixOS or Home Manager.
- Prefer declarative Nix configuration over imperative changes.
- Respect versions pinned in flake.lock.
- Do not update flake.lock unless explicitly requested.
- Do not run nixos-rebuild switch, boot, or test.
- Do not run home-manager switch.
- Do not use sudo.
- Never commit or push changes.
- Explain changes and verify them when possible.
- If a command fails twice, investigate rather than retrying blindly.

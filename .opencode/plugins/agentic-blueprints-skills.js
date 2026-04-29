/**
 * agentic-blueprints-skills plugin for OpenCode.ai
 *
 * Registers the bundled skills/ directory so OpenCode's native skill tool
 * discovers the five SKILL.md files. No runtime behavior beyond registration.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const skillsDir = path.resolve(__dirname, "..", "..", "skills");

export const AgenticBlueprintsSkillsPlugin = async ({ client, directory }) => {
  return {
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(skillsDir)) {
        config.skills.paths.push(skillsDir);
      }
    },
  };
};

export default AgenticBlueprintsSkillsPlugin;

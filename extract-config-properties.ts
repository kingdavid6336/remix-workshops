import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';
import { glob } from 'glob';

interface ConfigProperties {
  [key: string]: any;
}

async function extractConfigProperties(): Promise<void> {
  try {
    // Find all config.yml files
    const configFiles = await glob('**/config.yml', {
      ignore: 'node_modules/**'
    });

    console.log(`Found ${configFiles.length} config.yml files`);

    // Array to store all config properties
    const allConfigs: ConfigProperties[] = [];

    // Read and parse each config file
    for (const configFile of configFiles) {
      try {
        const fileContent = fs.readFileSync(configFile, 'utf8');
        const config = yaml.load(fileContent) as ConfigProperties;

        // Add file path for reference
        const configWithPath = {
          ...config
        };

        delete (configWithPath as any)['steps'];

        (configWithPath as any)['tags'] = (configWithPath as any)['tags'].join(', ');

        allConfigs.push(configWithPath);
        console.log(`Processed: ${configFile}`);
      } catch (error) {
        console.error(`Error processing ${configFile}:`, error);
      }
    }

    // Write to JSON file at root
    const outputPath = path.join(process.cwd(), 'config-properties.json');
    fs.writeFileSync(outputPath, JSON.stringify(allConfigs, null, 2), 'utf8');

    console.log(`\nSuccessfully created ${outputPath}`);
    console.log(`Total configs extracted: ${allConfigs.length}`);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

// Run the extraction
extractConfigProperties();

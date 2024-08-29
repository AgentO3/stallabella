# Stallabella: A Children's Story Generator

## How It Works

This project utilizes a bash script to automate the process of generating the story and its accompanying images. The script performs the following steps:

1. **Setup**: Creates necessary directories for the project and cache.
2. **Story Generation**: Uses a prompt to generate the story text based on the provided description.
3. **Image Prompt Creation**: Generates detailed prompts for each paragraph of the story to create corresponding images.
4. **Image Generation**: Uses the image prompts to generate images using a text-to-image model.
5. **Markdown Creation**: Compiles the story text and images into a markdown file for easy viewing.

## Requirements

To run the script, ensure you have the following:

- A Unix-like environment (Linux, macOS, or WSL on Windows)
- `curl` for downloading images
- `jq` for processing JSON files
- `cllm` for generating text and images https://github.com/o3-cloud/cllm
- OpenAI API Access
 
## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/stallabella.git
   cd stallabella
   ```

2. Run the script:
   ```bash
   bash story.sh
   ```

You can generate multiple version of the story by changing the version number in the `story.sh` script and story prompt and then run the script again.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

---

Thank you for exploring the Stallabella project! We hope you enjoy the story and the colorful illustrations that bring it to life.

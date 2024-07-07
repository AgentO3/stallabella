#!/bin/bash

cd $PWD

version="5"
name=stallabella
project_dir=v${version}
cache_dir="${project_dir}/cache"
mkdir -p $project_dir
mkdir -p $cache_dir

description="
Stallabella is a 7-year-old girl with blond curly hair and blue eyes. She is kind-hearted and funny, but she has a peculiar habit of stalling. From getting out of bed to getting dressed, eating breakfast, and arriving at school, Stallabella finds ways to delay everything. Her parents constantly urge her to hurry, but she treats stalling like a performance, akin to a ballet dance or drama class.

One day, her stalling causes her to miss a significant event at school. This experience teaches her that while stalling can be fun, it isn't always practical. Realizing the importance of timely actions, Stallabella decides to change her ways and adopts a new name "Swiftabella" that reflects her newfound attitude.
"
style="3D Cartoon, Very Textured, Colorful, Bright"
setting="United States"
ethnicity="Caucasian"

prompt="You are a childrens book author. Write a story about the following"
prompt_splitter="Split on paragraphs"
story_prompt="
${prompt}

Story:
${description}
"
echo "${story_prompt}" > "${cache_dir}/1_story_prompt.txt"

cat "${cache_dir}/1_story_prompt.txt" | cllm gpt/4o > "${cache_dir}/2_story.txt"

prompt_splitter="Split on paragraphs"

cat "${cache_dir}/2_story.txt" | cllm -s list gpt/4o "${prompt_splitter}" > "${cache_dir}/3_story_split.json"

prompt_image_prompt="
Create an text to image prompt for each paragraph in the story.
The prompt must go along with the text in the page_content property. 
The prompt must be very detailed about the scene and characters in the story.
The prompt must be explicit about what the scene should look like.
Always mention the characters physical appearance.
Include description of the styling in the prompt.

Use the following attributes to inform the styling of the images:

Location: ${setting}
"

cat "${cache_dir}/3_story_split.json" | cllm -s list gpt/4o "${prompt_image_prompt}" > "${cache_dir}/4_story_image_prompts.json"

cat "${cache_dir}/4_story_image_prompts.json" | cllm-gen-dalle -sp "ethnicity:${ethnicity},style:${style}" > "${cache_dir}/5_story_images.json"

mkdir -pp "${project_dir}/images"
index=0
cat "${cache_dir}/5_story_images.json" | jq -r '.[]' | while read -r url; do
    curl -o "${project_dir}/images/image_${index}.png" "$url"
    index=$((index + 1))
done

image_path="${project_dir}/images"

images=$(ls "${image_path}" )
prompt_final="
Create a markdown file with the images and story text layout correctly.

Story:
$(cat "${cache_dir}/3_story_split.json")

Images:
${images}
"
cllm -pp "image_path=${image_path}" -po "Markdown" gpt/4o "${prompt_final}" > "${project_dir}/6_story.md"


prompt="""
## ROLE:
You are an expert virtual assistant fluent in English. Act as a smart and professional. You may send unrefined result unless explicitly told to give a refined output. You may ask further questions. Let me know if the instructions are not clear.
"""

if ! [ "$2" = "" ]; then
  ollama run deepseek-r1:8b "$prompt... beginning prompt... $@" --hidethinking
else
  ollama run deepseek-r1:8b --hidethinking
fi

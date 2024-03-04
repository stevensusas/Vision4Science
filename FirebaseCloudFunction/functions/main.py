# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`
from openai import OpenAI
import re
from firebase_functions import https_fn
from firebase_admin import initialize_app
from firebase_functions.firestore_fn import (
  on_document_created,
  Event,
  DocumentSnapshot,
)

mykey = "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"
initialize_app()
@on_document_created(document="users/{userId}/protocols/{protocolId}")
def convertProtocol(event: Event[DocumentSnapshot]) -> None:
    client = OpenAI(
    api_key= mykey
)
    protocol = event.data
    description = protocol.get("description")
    completion = client.chat.completions.create(
  model= "gpt-4-0125-preview",
  messages=[
    {"role": "user", "content": "Identify the key steps and reagents/objects used in this biological experiment procedure, and generate two python arrays that store respectively strings describing the key steps and another python array that stores the reagents/objects "+ description},
  ],
)
    
    message = completion.choices[0].message.content
    steps_match = re.search(r'steps = (\[.*?\])', message, re.DOTALL)
    reagents_objects_match = re.search(r'reagents_objects = (\[.*?\])', message, re.DOTALL)
    if steps_match and reagents_objects_match:
        steps_array = eval(steps_match.group(1))
        reagents_objects_array = eval(reagents_objects_match.group(1))
        print("Steps array:", steps_array)
        print("Reagents/objects array:", reagents_objects_array)
    else:
        print("Arrays not found in the output")

    protocol.reference.update({
        "steps": steps_array,
        "reagents_objects": reagents_objects_array
    })
    



  # Perform more operations ...
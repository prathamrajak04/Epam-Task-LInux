This folder contains the initial architecture and technical research for Lumi.

## Contents
- Game architecture
- Technology stack
- Godot and GDScript research
- Game mechanics implementation
- AI engineering concepts
- Technical feasibility and challenges

## Guidelines
Upload architecture diagrams, technical notes, research documents, and implementation drafts here.

# Lumi's Memory System for Lumora

Lumi is designed to be a friendly and supportive companion who stays with the player throughout their journey across the ten universes and even after the game ends. To make conversations feel natural and personal, Lumi needs a way to remember the current conversation and retain useful information for future interactions.

For this, we will use a conversation buffer for real-time conversations and semantic memory stored in an SQLite database.

The conversation buffer will hold the recent messages exchanged between the player and Lumi. This will help Lumi understand the current topic, follow the conversation, and respond naturally without losing track of what was said a few messages earlier. The buffer is temporary and can be cleared or reset according to the session policy.

Semantic memory will store useful information that the player has agreed to save, such as their interests, communication preferences, goals, and skills they have practised in the game. SQLite will provide a lightweight way to store this information locally on the player's device, allowing Lumi to access it when the player returns in a future session.

When the player starts a conversation, Lumi's system will combine the recent messages from the buffer with relevant information retrieved from SQLite and the player's current game progress. This context will help Lumi provide responses that feel connected to the player's previous experiences.

For example, if a player previously practised breaking a large task into smaller steps, Lumi may recall this when the player later asks for help with a similar challenge. It can gently suggest revisiting that approach while allowing the player to choose what works for them.

We will not store every conversation permanently. Only useful information should be saved with appropriate permission, and players should be able to view, correct, or delete their saved memories. Personal reflections should remain optional, and sensitive information should not be stored unnecessarily.

This approach keeps the system simple for the first version of Lumora. The conversation buffer will manage immediate context, while SQLite-based semantic memory will provide continuity across sessions. Together, they will help Lumi feel more personal and consistent while respecting the player's privacy and choices.

<img width="731" height="740" alt="Execution Flow Diagram" src="https://github.com/user-attachments/assets/0b5c80ac-4c59-4124-94ce-5c828c16a110" />


# Lumi’s Voice and Safety System

Lumi is designed to feel like a natural, caring companion who listens to the player and responds in a warm, human-like way. Since Lumora is being developed for Android, we plan to use speech-to-speech technology to make conversations faster and smoother. Instead of waiting for the full voice recording to be converted into text before Lumi responds, audio can be sent in small chunks to reduce the waiting time and make conversations feel more natural.

To help Lumi remember the player, we plan to use a conversation buffer and semantic memory stored locally in SQLite. The conversation buffer will temporarily hold recent messages so Lumi can follow the ongoing conversation. Semantic memory will store only useful information, such as the player's interests, communication preferences, goals and skills they have practised in the game. We will not save every conversation. Players should have control over what Lumi remembers, including the ability to view, correct or delete stored memories.

Safety is one of the most important parts of Lumi's design. Before voice data is sent to the AI, Lumora will use a local safety check to identify possible crisis situations. If a serious concern is detected, the game will stop the normal conversation and show a reviewed help screen with appropriate support resources. Lumi will also follow clear boundaries: it should not diagnose players, make unsupported clinical claims or replace professional help. On the response side, the game will check Lumi's generated speech before playing it where required, block unsafe responses and use reviewed fallback messages if a safety check fails. A visible “Get help now” option will remain available.

In the future, we may integrate NVIDIA NeMo Guardrails on the backend to add more structured checks for user input, Lumi's responses and the conversation rules. This would be an additional layer of protection, not a replacement for Lumora's local crisis checks or playback controls.

Our goal is to make Lumi feel responsive, personal and supportive while keeping the player's privacy, safety and control at the centre of the experience.

# Implementation of Lumora’s Local Crisis System

On Android, Lumora will run a lightweight, on-device safety module before sending voice data to the AI. Incoming audio chunks will be temporarily buffered and processed by local speech recognition to generate provisional text. A local crisis detector will analyse the evolving text and context for potential self-harm, suicidal intent or immediate danger.

If a high-risk signal is detected, the app will stop forwarding audio, cancel the active AI response where possible and display a locally stored, pre-reviewed support screen. If recognition or detection fails, the system will follow a safe fallback policy rather than automatically assuming the conversation is safe. A “Get help now” option will remain accessible offline.

<img width="900" height="607" alt="Diagram Creation Workflow" src="https://github.com/user-attachments/assets/712e6da1-168c-4f13-bec7-0a1a7c934dd9" />

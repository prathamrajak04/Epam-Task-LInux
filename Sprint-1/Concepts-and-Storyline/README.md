# 🌌 LUMORA — Game Flow & Story Design

> **A personalized journey of exploration, reflection, and self-discovery.**

Lumora is a lightweight, cinematic 2.5D wellbeing game inspired by Cognitive Behavioral Therapy (CBT) principles. Through interactive storytelling, gentle puzzles, exploration, and optional reflection, players embark on a personalized journey alongside **Lumi**, a kind lantern companion.

Set in a mysterious, fog-covered grassy dimension, Lumora combines immersive gameplay with thoughtful design to encourage self-awareness, balanced thinking, and healthier coping skills.

---

## 📌 Project Overview

| Attribute | Details |
|---|---|
| Project Name | Lumora |
| Project Type | 2.5D Wellbeing Adventure Game |
| Game Engine | Godot |
| Core Companion | Lumi |
| Design Approach | Game-first, modular, and personalized |
| Core Inspiration | CBT-informed principles |
| Current Phase | Concept and Experience Design |

### 🎯 Vision

To create an accessible, engaging gaming experience where players can explore their emotions, discover helpful perspectives, and develop a greater understanding of themselves — at their own pace.

Lumora prioritizes meaningful gameplay over long questionnaires, allowing personalization to emerge naturally through exploration, choices, activities, and optional conversations.

## 📖 Story Premise

The journey begins when the player enters a quiet, unfamiliar dimension covered in mist and surrounded by soft, grassy landscapes.

Here, they encounter **Lumi**, a small lantern companion whose gentle light symbolizes hope, curiosity, and finding a way forward.

Rather than acting as an all-knowing guide, Lumi accompanies the player as a fellow explorer. Through shared discoveries and interactive experiences, Lumi gradually learns about the player's interests, preferences, and self-expressed experiences.

The journey is designed to progress emotionally from:

**Unfamiliarity → Trust → Curiosity → Agency → Personal Direction**

Each environment, interaction, and activity contributes to this progression while keeping the player in control of their experience.

## 🕹️ Core Gameplay Flow

Lumora follows a shared introduction followed by a dynamically assembled, personalized journey.

### 1. Start & Customize
The player launches Lumora and completes a lightweight avatar or profile setup.

### 2. Enter the Dimension
A cinematic transition introduces the player to the mysterious, fog-covered grassy world.

### 3. Meet Lumi
The player meets Lumi, establishing the game's supportive tone and introducing the companion's role.

### 4. Learn Through Play
Interactive onboarding introduces movement, exploration, object interactions, and mini-game mechanics.

### 5. Discover the Player
Through optional conversations, choices, activities, and light reflection, Lumi learns about the player's interests and preferences.

### 6. Build the Journey
A lightweight, on-device classification or recommendation process selects suitable level types and arranges them into a personalized sequence.

### 7. Preview & Download
The player reviews the proposed journey and provides consent before selected content is downloaded.

### 8. Play & Adapt
The player explores environments, completes activities, reflects when comfortable, and provides feedback that can inform future recommendations.

**Design principle:** Lumora does not rely on a conventional branching narrative tree. Instead, it aims to create personalized journeys by selecting and ordering modular gameplay experiences.

## 🏮 Lumi — The Companion

Lumi is central to the emotional and interactive experience of Lumora.

**Lumi's responsibilities:**
- Guide the player through unfamiliar environments.
- Encourage exploration, curiosity, and independent choices.
- Learn from player-approved preferences and optional interactions.
- Recall relevant, player-approved memories without assuming more than the player has shared.
- Acknowledge progress without judging or scoring the player's emotional state.

Lumi is designed to feel like a supportive companion rather than a therapist, evaluator, or authority figure.

## 🧩 Standard Level Experience

Each level can follow a reusable gameplay structure while introducing different environments, mechanics, and activities.

| Phase | Experience |
|---|---|
| Explore | Navigate a calm 2.5D environment and discover interactive elements. |
| Interact | Engage in brief, contextual conversations with Lumi. |
| Play | Complete mini-games, puzzles, or skill-practice activities. |
| Reflect | Optionally consider an experience or a different perspective. |
| Recognize | Experience a visual or narrative moment acknowledging progress. |
| Carry Forward | Preserve relevant preferences, reflections, and activity feedback where appropriate. |

This modular structure allows different level themes to share a consistent experience while offering varied gameplay.

## 🧠 Dynamic Journey Personalization

Lumora aims to adapt the player's journey based on voluntarily shared information and feedback.

### Personalization Inputs
- Interests and themes shared by the player.
- Preferred activities and engagement patterns.
- Player-stated situations or goals.
- Optional, self-reported feelings and reflections.
- Feedback about activities or coping approaches.

### Journey-Building Process

1. Collect relevant information during the shared introduction.
2. Explain personalization in clear, player-friendly language.
3. Recommend suitable level types and their sequence using lightweight local processing.
4. Present the proposed journey and request permission before downloading selected content.
5. Allow the player to start, skip, pause, or revisit suitable activities.
6. Refine future recommendations using subsequent interactions and feedback.

The exact content categories, recommendation rules, and fallback behavior remain part of ongoing design work.

## 🔐 Privacy, Memory & Content Delivery

Privacy is an important consideration in Lumora's design.

Current design principles include:

- Keep personal conversation history and journey memories primarily on the player's device.
- Minimize unnecessary personal-data collection and server-side retention.
- Clearly explain how personalization works and what information is processed locally or remotely.
- Provide controls to review, reset, or opt out of personalization where feasible.
- Request consent before downloading selected journey content.
- Avoid transmitting the entire personal memory store when a feature needs only limited context.

These are design objectives; detailed implementation, data schemas, and controls remain to be developed and validated.

## 💚 Wellbeing & Safety Principles

Lumora is a non-clinical wellbeing experience informed by CBT principles. It is intended to support self-awareness and the practice of helpful coping skills through gameplay.

The design aims to:

- Keep reflection optional and avoid intrusive questioning.
- Encourage player agency without shame, pressure, or emotional judgment.
- Avoid diagnosis, clinical scoring, treatment claims, and guaranteed outcomes.
- Avoid presenting Lumi as a therapist or encouraging emotional dependence.
- Validate wellbeing content and safety flows with qualified reviewers.
- Establish appropriate procedures and support resources for distress or crisis disclosures before release.
- Complete privacy and age-appropriateness reviews before deployment.

Lumora is not intended to replace professional mental-health care.

## 🚀 Current Progress & Next Steps

### Defined in This Sprint
- Shared onboarding and the initial meeting with Lumi.
- High-level gameplay flow from introduction to personalized gameplay.
- Dynamic journey-building concept using modular content.
- Reusable level-experience structure.
- Initial privacy, content-download consent, and wellbeing principles.

### Upcoming Work
- Define the level taxonomy and recommendation metadata.
- Map player-discovery moments to appropriate activities and consent points.
- Prototype and test a sample personalized journey.
- Specify journey-builder inputs, outputs, and fallback behavior.
- Review wellbeing prompts and safety workflows with qualified reviewers.
- Validate gameplay pacing and clarity through internal playtesting and mentor feedback.

## 📂 Repository Context

This document belongs to the **Concepts and Storyline** section of the Lumora sprint documentation. It records the current direction of the game's narrative, player journey, and experience design.

The project is being developed iteratively, and the concepts described here may evolve through prototyping, playtesting, team discussions, and mentor feedback.

---

## ✨ Our Guiding Principle

*Build a world where players are free to explore, a companion who listens without judgment, and a journey that adapts without taking away the player's control.*

**LUMORA — Every journey begins with a little light.**

---

*Document Status: Sprint Report Draft*  
*Scope: Game Flow, Story Premise, Personalization, and Experience Design*  
*Note: Content definitions, progression rules, safety requirements, and technical implementation remain subject to iteration.*

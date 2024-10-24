import 'package:banter/src/note_manager/domain/entity/note_entity.dart';

final defaultNote = NoteEntity(
    id: 'welcome_note',
    title: 'Read Me',
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    body: defaultContent,
    folderIds: [],
    ownerId: '');

var defaultContent = [
  {
    "insert": "Welcome to Banter! 📝",
    "attributes": {"bold": true}
  },
  {
    "insert": "\n",
    "attributes": {"header": 2}
  },
  {
    "insert":
        "Hello there, and welcome to Banter—your all-in-one solution for taking notes, jotting down ideas, and organizing your thoughts! 🎉\n\nBefore you dive in, here's a quick tour of the app’s features:\n\n"
  },
  {
    "insert": "1. ",
    "attributes": {"bold": true, "size": "huge"}
  },
  {
    "insert": "Bold Ideas 💡",
    "attributes": {"bold": true, "size": "large"}
  },
  {"insert": "\nYou can emphasize "},
  {
    "insert": "important",
    "attributes": {"bold": true}
  },
  {"insert": " parts of your notes with "},
  {
    "insert": "bold text.",
    "attributes": {"bold": true}
  },
  {"insert": "\n\n"},
  {
    "insert": "2. Italic Thoughts",
    "attributes": {"size": "large", "italic": true}
  },
  {
    "insert": " 🤔",
    "attributes": {"bold": true, "size": "large"}
  },
  {
    "insert":
        "\nSometimes you just want to highlight things in a subtle way. That's where "
  },
  {
    "insert": "italic",
    "attributes": {"italic": true}
  },
  {"insert": " text comes in handy!\n\n"},
  {
    "insert": "3. Bold & ",
    "attributes": {"bold": true, "size": "large"}
  },
  {
    "insert": "Italic",
    "attributes": {"bold": true, "size": "large", "italic": true}
  },
  {
    "insert": " Combo",
    "attributes": {"bold": true, "size": "large"}
  },
  {"insert": "\nFeeling extra expressive? Combine them both with "},
  {
    "insert": "bold ",
    "attributes": {"bold": true}
  },
  {
    "insert": "italic",
    "attributes": {"bold": true, "italic": true}
  },
  {"insert": " text to make your notes pop!\n\n"},
  {
    "insert": "4. Organize Your Notes with Headings 🏷️",
    "attributes": {"size": "large"}
  },
  {
    "insert":
        "\nYou can break down your notes into sections with different heading sizes.\n\n"
  },
  {
    "insert": "5. Underline Your Important Points",
    "attributes": {"size": "large"}
  },
  {"insert": "\nWant to add emphasis? You can "},
  {
    "insert": "underline",
    "attributes": {"underline": true}
  },
  {"insert": " those really important sections.\n\n"},
  {
    "insert": "6. Bullet Points for Lists 📋",
    "attributes": {"size": "large"}
  },
  {
    "insert":
        "\nNeed to keep track of tasks, groceries, or anything else? Here’s how you can create bullet point lists:\n\n"
  },
  {
    "insert": "Buy more coffee ☕",
    "attributes": {"list": "bullet"}
  },
  {"insert": "\n"},
  {
    "insert": "Take over the world 🌍",
    "attributes": {"list": "bullet"}
  },
  {"insert": "\n"},
  {
    "insert": "Don't forget to feed the goat 🐐",
    "attributes": {"list": "bullet"}
  },
  {"insert": "\n\n"},
  {
    "insert": "7. Numbered Lists 🔢",
    "attributes": {"size": "large"}
  },
  {"insert": "\nWant something more structured? Use numbered lists:\n\n"},
  {
    "insert": "Wake up (maybe) 😴",
    "attributes": {"list": "ordered"}
  },
  {"insert": "\n"},
  {
    "insert": "Make amazing notes in QuickNote 🎨",
    "attributes": {"list": "ordered"}
  },
  {"insert": "\n"},
  {
    "insert": "???",
    "attributes": {"list": "ordered"}
  },
  {"insert": "\n"},
  {
    "insert": "Profit 💸",
    "attributes": {"list": "ordered"}
  },
  {"insert": "\n\n"},
  {
    "insert": "8. Quote Your Inspirations 🌟",
    "attributes": {"size": "large"}
  },
  {"insert": "\nWhen life gives you lemons, remember this:\n\n"},
  {
    "insert":
        "\"I am not a product of my circumstances. I am a product of my decisions.\"",
    "attributes": {"blockquote": true}
  },
  {"insert": "\n"},
  {
    "insert": "— Stephen Covey",
    "attributes": {"blockquote": true}
  },
  {"insert": "\n\n"},
  {
    "insert": "9. Checklists ✔️",
    "attributes": {"size": "large"}
  },
  {
    "insert":
        "\nBanter even lets you create checklists to mark things off as you complete them:\n\n"
  },
  {
    "insert": " Download Banter",
    "attributes": {"list": "checked"}
  },
  {"insert": "\n"},
  {
    "insert": " Write your first note",
    "attributes": {"list": "unchecked"}
  },
  {"insert": "\n"},
  {
    "insert": " Rule the note-taking world! 🌍",
    "attributes": {"list": "unchecked"}
  },
  {
    "insert":
        "\n\nEnjoy exploring all that Banter has to offer!\nHappy note-taking! 😊\n\n"
  }
];

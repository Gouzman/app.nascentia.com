import re

# Read the snapshot
with open('project_code_snapshot.txt', 'r', encoding='utf-8') as f:
    snapshot = f.read()

# Extract hero_section.dart
hero_match = re.search(
    r'===== FILE: .*hero_section\.dart =====\n(.*?)(?=\n===== FILE:|\Z)', 
    snapshot, 
    re.DOTALL
)
if hero_match:
    with open('lib/sections/hero_section.dart', 'w', encoding='utf-8') as f:
        f.write(hero_match.group(1).strip() + '\n')
    print("✓ Restored lib/sections/hero_section.dart")

# Extract app_section.dart  
app_match = re.search(
    r'===== FILE: .*app_section\.dart =====\n(.*?)(?=\n===== FILE:|\Z)', 
    snapshot, 
    re.DOTALL
)
if app_match:
    with open('lib/sections/app_section.dart', 'w', encoding='utf-8') as f:
        f.write(app_match.group(1).strip() + '\n')
    print("✓ Restored lib/sections/app_section.dart")

# Extract app_footer.dart
footer_match = re.search(
    r'===== FILE: .*widgets.*app_footer\.dart =====\n(.*?)(?=\n===== FILE:|\Z)', 
    snapshot, 
    re.DOTALL
)
if footer_match:
    with open('lib/widgets/app_footer.dart', 'w', encoding='utf-8') as f:
        f.write(footer_match.group(1).strip() + '\n')
    print("✓ Restored lib/widgets/app_footer.dart")

print("\nAll files restored from backup!")

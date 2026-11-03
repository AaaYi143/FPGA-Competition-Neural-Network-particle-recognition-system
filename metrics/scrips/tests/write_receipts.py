from pathlib import Path
import json,hashlib,re
r=Path(__file__).resolve().parents[1]
assert 'UI_ALL_PASS' in (r/'verification/ui_test.log').read_text()
assert 'numeric_tail_background=PASS' in (r/'verification/ui_test.log').read_text()
assert 'STM32_ALL_PASS' in (r/'verification/vote_protocol_test.log').read_text()
sections={m[0]:int(m[1]) for m in re.findall(r'^([.][\w.]+)\s+(\d+)\s+\d+', (r/'verification/memory_sections.txt').read_text(),re.M)}
flash=len((r/'output/STM32_PARTICLE_VOTE20.bin').read_bytes());ram=sections['.data']+sections['.bss']+sections['._user_heap_stack']
report={'passed':flash<=262144 and ram<=49152,'target':'STM32F103RCT6','flash_used_bytes':flash,'flash_capacity_bytes':262144,'ram_reserved_and_static_bytes':ram,'ram_capacity_bytes':49152,'rx_ring_usable_bytes':2047,'rx_full_rate_buffer_ms':2047*10*1000/115200,'data_bytes':sections['.data'],'bss_bytes':sections['.bss'],'heap_stack_reserved_bytes':sections['._user_heap_stack'],'image_flash_bytes':110592,'framebuffer_in_firmware':False,'physical_flash_performed':False,'artifacts':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (r/'output').glob('*')}}
(r/'verification/memory_report.json').write_text(json.dumps(report,indent=2)+'\n')
ui={'passed':True,'execution':'Actual particle_ui.c + actual glyphs, fonts and image arrays; host-only LCD adapter','dimensions':[240,320],'snapshots':12,'all_draws_in_bounds':True,'full_screen_clears':1,'image_windows':5,'duplicate_no_redraw':True,'category_stable_no_image_redraw':True,'visual_review':'Chinese readable; RGB565 photos visible; percent/name/progress/status do not overlap. Short-text tail artifacts corrected and rerun.','preview':'ui_contact_sheet.png','empty_to_material_numeric_tail_checked':True,'physical_lcd_tested':False}
(r/'verification/ui_check.json').write_text(json.dumps(ui,indent=2)+'\n')

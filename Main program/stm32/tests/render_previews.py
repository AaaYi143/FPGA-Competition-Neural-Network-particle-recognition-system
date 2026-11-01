from pathlib import Path
from PIL import Image,ImageDraw
root=Path(__file__).resolve().parents[1]/'verification'
files=list(root.glob('ui_*.ppm'))
for p in files: Image.open(p).save(p.with_suffix('.png'))
sel=['ui_class1_90pct','ui_class2_warmup','ui_class3_90pct','ui_class4_90pct','ui_empty','ui_timeout']
canvas=Image.new('RGB',(720,680),'#eeeeee')
d=ImageDraw.Draw(canvas)
for i,name in enumerate(sel):
 x=(i%3)*240;y=(i//3)*340;d.text((x+4,y+3),name,fill='black');canvas.paste(Image.open(root/(name+'.png')),(x,y+20))
canvas.save(root/'ui_contact_sheet.png')

require 'win32ole'
require 'yaml'
def write_excel(header,tables=nil,pools=nil)
  excel = WIN32OLE::new('excel.Application')
  workbook = excel.workbooks.add
  worksheet = workbook.Worksheets(1)
  worksheet.Select
  worksheet.Range('A1:D1').value= header
  workbook.saveas('d:\1.xlsx')
  workbook.Close(1)
  excel.quit
end

def build_data
  hash_1={}
  hash_2={}
  hash_3={}
  arr=[]
  hash_1['a']='a'
  hash_1['b']='b'
  hash_2['a']='a'
  hash_2['b']='b'

  arr[0]=hash_1
  arr[1]=hash_2
  puts arr
  hash_3['x']=arr
  puts hash_3['x'].length
end

if __FILE__==$0
  $tables_config = YAML::load(File.open('tables.yml'))
  $tables_config['MMP'].split(' ').each { |t|  puts t }
  header=['timerange','poolname','PROD','BTS']
  # write_excel header
  build_data
end
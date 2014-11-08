require 'win32ole'
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

if __FILE__==$0
  header=['timerange','poolname','PROD','BTS']
  write_excel header
end
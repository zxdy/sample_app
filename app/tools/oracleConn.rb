require 'oci8'
require 'win32ole'


excel = WIN32OLE::new('excel.Application')
workbook = excel.workbooks.add
worksheet = workbook.Worksheets(1)
worksheet.Select


conn_bts = OCI8.new('')
AVW_TSPEVENTS_RAW_count = conn_bts.exec("select count(1)
FROM AVW_TSPEVENTS_RAW a
WHERE a.TIMESTAMP >= to_date( '10/06/2014' , 'mm/dd/yyyy hh24:mi:ss')
AND a.TIMESTAMP    < to_date( '10/08/2014' , 'mm/dd/yyyy hh24:mi:ss')+1 and pool='ptta4'")do |r|
  worksheet.Range('a1').value = r.join(',')
end

workbook.saveas('c:\spreadsheet.xls')
workbook.Close(1)


using Kyrsovoi.DB_;
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Data.Entity;
using System.IO;
using OfficeOpenXml;
using Microsoft.Win32;
using System.Data;
using System.Diagnostics;

namespace Kyrsovoi.Pages_
{
    /// <summary>
    /// Логика взаимодействия для DatagridPage.xaml
    /// </summary>
    public partial class DatagridPage : Page
    {
        private KyrsovoyProjectEntities _context;
        public DatagridPage()
        {
            InitializeComponent();
            DGridRasp.ItemsSource = KyrsovoyProjectEntities.GetContext().Расписание.ToList();
            DGridStud.ItemsSource = KyrsovoyProjectEntities.GetContext().Студенты.ToList();
            DGridgroup.ItemsSource = KyrsovoyProjectEntities.GetContext().Группа.ToList();
            DGridPred.ItemsSource = KyrsovoyProjectEntities.GetContext().Преподаватель.ToList(); 
            DGridPredmet.ItemsSource = KyrsovoyProjectEntities.GetContext().Предмет.ToList();
            _context = new KyrsovoyProjectEntities();
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                KyrsovoyProjectEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridRasp.ItemsSource = KyrsovoyProjectEntities.GetContext().Расписание.ToList();
            }
        }

        private void BtnRed_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AdddEditPage((sender as Button).DataContext as Расписание));
        }
        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AdddEditPage(null));
        }

        private void BtnDel_Click(object sender, RoutedEventArgs e)
        {
            var SotrForRemoving = DGridRasp.SelectedItems.Cast<Расписание>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить следующие {SotrForRemoving.Count()} элементов?", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    KyrsovoyProjectEntities.GetContext().Расписание.RemoveRange(SotrForRemoving);
                    KyrsovoyProjectEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены!");
                    //DGridStudents.ItemsSource = KyrsovoyProjectEntities.GetContext().Расписание.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }

            }
        }
        private void tbsearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            //var currentTours = KyrsovoyProjectEntities.GetContext().Студенты.ToList();
            //currentTours = currentTours.Where(p => p.Имя.ToLower().Contains(tbsearch.Text.ToLower())).ToList();
            //DGridStudents.ItemsSource = currentTours.OrderBy(p => p.Имя).ToList();
        }

        private void bt_rasp_Click(object sender, RoutedEventArgs e)
        {
            GenerateSchedule();
        }
        private void ClearSchedule()
        {
            _context.Расписание.RemoveRange(_context.Расписание); // Удаление всех записей
            _context.SaveChanges();
        }
        private void GenerateSchedule()
        {
            ClearSchedule(); 
            var groups = _context.Группа.ToList();
            var teachers = _context.Преподаватель.ToList();
            var rooms = _context.Кабинет.ToList();
            var preds = _context.Предмет.ToList();

            var random = new Random();

            for (int i = 0; i < 3; i++)
            {             
                foreach (var group in groups)
                {
                var day = DateTime.Today;
                var teacher = teachers[random.Next(teachers.Count)]; 
                var room = rooms[random.Next(rooms.Count)]; 
                var pred = preds[random.Next(preds.Count)];

                var schedule = new Расписание
                {
                    Id_группы = group.Id_группы,
                    Id_преподавателя = teacher.Id_преподавателя,
                    Id_кабинета = room.Id_кабинета,
                    Id_предмета = pred.Id_предмета,
                    День = day
                };
                _context.Расписание.Add(schedule);
                }
            _context.SaveChanges();
            }
        // Загрузка сгенерированного расписания в DataGrid
        var scheduleData = _context.Расписание.Include(s => s.Группа).Include(s => s.Преподаватель).Include(s => s.Кабинет).Include(s =>s.Предмет).ToList();
            DGridRasp.ItemsSource = scheduleData;
            MessageBox.Show("Расписание успешно сформировано!");
        }
        private void bt_otch_Click(object sender, RoutedEventArgs e)
        {
            //var saveFileDialog = new SaveFileDialog()
            //{
            //    Filter = "Excel Files|*.xlsx",
            //    FileName = "data",
            //    InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
            //};
            //// Если пользователь нажал кнопку "Сохранить"
            //if (saveFileDialog.ShowDialog() == true)
            //{
            //    // Создаем новый пакет Excel
            //    ExcelPackage package = new ExcelPackage();
            //    var worksheet = package.Workbook.Worksheets.Add("Data");

            //    // Записываем данные из DataGrid в Excel
            //    int row = 1;
            //    foreach (var item in DGridRasp.Items)
            //    {
            //        int col = 1;
            //        foreach (var property in item.GetType().GetProperties())
            //        {
            //            worksheet.Cells[row, col].Value = property.GetValue(item);
            //            col++;
            //        }
            //        row++;
            //    }
            //    // Сохраняем пакет Excel в выбранный файл
            //    package.SaveAs(new FileInfo(saveFileDialog.FileName));

            //    MessageBox.Show("Данные сохранены в XLSX файл.");
            //}
            var data = GetDataTableFromGrid(DGridRasp);
            // экспорт в Excel
            ExportToExcel(data);
            // открыть файл
            OpenGeneratedExcelFile();
        }
        private DataTable GetDataTableFromGrid(DataGrid dg)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id");
            dt.Columns.Add("Группа");
            dt.Columns.Add("Препод");
            dt.Columns.Add("Предмет");
            dt.Columns.Add("Время");
            dt.Columns.Add("День");
            dt.Columns.Add("Кабинет");
            foreach (var item in dg.ItemsSource)
            {
                Расписание note = item as Расписание;
                dt.Rows.Add(note.Id_расписания, note.Id_группы,
                note.Id_преподавателя, note.Id_предмета, note.Время_занятий, note.День, note.Id_кабинета);
            }
            return dt;
        }
        private void ExportToExcel(DataTable data)
        {
            var dialog = new SaveFileDialog();
            dialog.Filter = "Excel | *.xlsx";
            if (dialog.ShowDialog() == true)
            {
                using (ExcelPackage excel = new ExcelPackage())
                {
                    var worksheet = excel.Workbook.Worksheets.Add("Data");
                    worksheet.Cells["A1"].LoadFromDataTable(data, true);
                    FileInfo file = new FileInfo(dialog.FileName);
                    excel.SaveAs(file);
                }
            }
        }
        private void OpenGeneratedExcelFile()
        {
            var dialog = new OpenFileDialog();
            dialog.Filter = "Excel | *.xlsx";
            if (dialog.ShowDialog() == true)
            {
                Process.Start(dialog.FileName);
            }
        }
    }
}

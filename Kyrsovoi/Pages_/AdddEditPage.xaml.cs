using Kyrsovoi.DB_;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Kyrsovoi.Pages_
{
    /// <summary>
    /// Логика взаимодействия для AdddEditPage.xaml
    /// </summary>
    public partial class AdddEditPage : Page
    {
        private Расписание _расписание = new Расписание();
        public AdddEditPage(Расписание selectStudents)
        {
            InitializeComponent();
            if(selectStudents != null) 
            {
                _расписание = selectStudents; 
            }
            DataContext = _расписание;
            СbGroup.ItemsSource = KyrsovoyProjectEntities.GetContext().Группа.ToList();
            СbCourses.ItemsSource = KyrsovoyProjectEntities.GetContext().Курс.ToList();
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();

            if (_расписание.Предмет == null)
            {
                errors.AppendLine("Выберите Предмет");
            }
            if (_расписание.Группа == null)
            {
                errors.AppendLine("Выберите Группу");
            }
            if (_расписание.Кабинет == null)
            {
                errors.AppendLine("Выберите Кабинет");
            }
            if (_расписание.Преподаватель == null)
            {
                errors.AppendLine("Выберите Преподавателя");
            }
            if (_расписание.День == null)
            {
                errors.AppendLine("Укажите День");
            }
           
            //вывод ошибок
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            // добавление сотрудника
            if (_расписание.Id_расписания == 0)
            {
                KyrsovoyProjectEntities.GetContext().Расписание.Add(_расписание);
            }
            try
            {
                KyrsovoyProjectEntities.GetContext().SaveChanges();
                MessageBox.Show("Данные успешно сохранены!");
                Manager.MainFrame.GoBack();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}

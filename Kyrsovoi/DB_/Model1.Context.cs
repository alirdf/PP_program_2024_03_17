﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Kyrsovoi.DB_
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class KyrsovoyProjectEntities : DbContext
    {
        private static KyrsovoyProjectEntities _context;
        public KyrsovoyProjectEntities()
            : base("name=KyrsovoyProjectEntities")
        {
        }
       
        private static KyrsovoyProjectEntities GetContext()
        {
            if (_context == null)
                _context = new KyrsovoyProjectEntities();
            return _context;
        }


    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Время_занятий> Время_занятий { get; set; }
        public virtual DbSet<Группа> Группа { get; set; }
        public virtual DbSet<Кабинет> Кабинет { get; set; }
        public virtual DbSet<Курс> Курс { get; set; }
        public virtual DbSet<Предмет> Предмет { get; set; }
        public virtual DbSet<Преподаватель> Преподаватель { get; set; }
        public virtual DbSet<Расписание> Расписание { get; set; }
        public virtual DbSet<Студенты> Студенты { get; set; }
    }
}

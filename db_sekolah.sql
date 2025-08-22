-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 22, 2025 at 01:46 AM
-- Server version: 8.0.43-0ubuntu0.24.04.1
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sekolah`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_artikel`
--

CREATE TABLE `tb_artikel` (
  `id_artikel` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi` text,
  `tanggal` date DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_buku_tabungan`
--

CREATE TABLE `tb_buku_tabungan` (
  `id_buku_tabungan` int NOT NULL,
  `id_siswa` int NOT NULL,
  `id_jenis_tabungan` int NOT NULL,
  `saldo` decimal(15,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_galeri`
--

CREATE TABLE `tb_galeri` (
  `id_galeri` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text,
  `gambar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_guru`
--

CREATE TABLE `tb_guru` (
  `id_guru` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `nama_guru` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `no_telp` varchar(50) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_jenis_kelas`
--

CREATE TABLE `tb_jenis_kelas` (
  `id_jenis_kelas` int NOT NULL,
  `nama_jenis_kelas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_jenis_tabungan`
--

CREATE TABLE `tb_jenis_tabungan` (
  `id_jenis_tabungan` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `nama_jenis_tabungan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_jurusan`
--

CREATE TABLE `tb_jurusan` (
  `id_jurusan` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `nama_jurusan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_kelas`
--

CREATE TABLE `tb_kelas` (
  `id_kelas` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `id_jurusan` int DEFAULT NULL,
  `id_jenis_kelas` int DEFAULT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `wali_kelas` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_kelas_siswa`
--

CREATE TABLE `tb_kelas_siswa` (
  `id_kelas` int NOT NULL,
  `id_siswa` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_krs`
--

CREATE TABLE `tb_krs` (
  `id_krs` int NOT NULL,
  `id_siswa` int NOT NULL,
  `id_mapel` int NOT NULL,
  `tahun_ajaran` varchar(50) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_mapel`
--

CREATE TABLE `tb_mapel` (
  `id_mapel` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `nama_mapel` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_pengampu_mapel`
--

CREATE TABLE `tb_pengampu_mapel` (
  `id_guru` int NOT NULL,
  `id_mapel` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_prestasi`
--

CREATE TABLE `tb_prestasi` (
  `id_prestasi` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sekolah`
--

CREATE TABLE `tb_sekolah` (
  `id_sekolah` int NOT NULL,
  `nama_sekolah` varchar(255) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telp` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_siswa`
--

CREATE TABLE `tb_siswa` (
  `id_siswa` int NOT NULL,
  `id_sekolah` int NOT NULL,
  `nisn` varchar(50) NOT NULL,
  `nama_siswa` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `no_telp` varchar(50) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_transaksi_tabungan`
--

CREATE TABLE `tb_transaksi_tabungan` (
  `id_transaksi` int NOT NULL,
  `id_buku_tabungan` int NOT NULL,
  `id_guru` int NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `jenis_transaksi` enum('setor','tarik') NOT NULL,
  `jumlah` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_artikel`
--
ALTER TABLE `tb_artikel`
  ADD PRIMARY KEY (`id_artikel`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_buku_tabungan`
--
ALTER TABLE `tb_buku_tabungan`
  ADD PRIMARY KEY (`id_buku_tabungan`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_jenis_tabungan` (`id_jenis_tabungan`);

--
-- Indexes for table `tb_galeri`
--
ALTER TABLE `tb_galeri`
  ADD PRIMARY KEY (`id_galeri`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_guru`
--
ALTER TABLE `tb_guru`
  ADD PRIMARY KEY (`id_guru`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_jenis_kelas`
--
ALTER TABLE `tb_jenis_kelas`
  ADD PRIMARY KEY (`id_jenis_kelas`);

--
-- Indexes for table `tb_jenis_tabungan`
--
ALTER TABLE `tb_jenis_tabungan`
  ADD PRIMARY KEY (`id_jenis_tabungan`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_jurusan`
--
ALTER TABLE `tb_jurusan`
  ADD PRIMARY KEY (`id_jurusan`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `id_sekolah` (`id_sekolah`),
  ADD KEY `id_jurusan` (`id_jurusan`),
  ADD KEY `id_jenis_kelas` (`id_jenis_kelas`),
  ADD KEY `wali_kelas` (`wali_kelas`);

--
-- Indexes for table `tb_kelas_siswa`
--
ALTER TABLE `tb_kelas_siswa`
  ADD PRIMARY KEY (`id_kelas`,`id_siswa`),
  ADD KEY `id_siswa` (`id_siswa`);

--
-- Indexes for table `tb_krs`
--
ALTER TABLE `tb_krs`
  ADD PRIMARY KEY (`id_krs`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tb_mapel`
--
ALTER TABLE `tb_mapel`
  ADD PRIMARY KEY (`id_mapel`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_pengampu_mapel`
--
ALTER TABLE `tb_pengampu_mapel`
  ADD PRIMARY KEY (`id_guru`,`id_mapel`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tb_prestasi`
--
ALTER TABLE `tb_prestasi`
  ADD PRIMARY KEY (`id_prestasi`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_sekolah`
--
ALTER TABLE `tb_sekolah`
  ADD PRIMARY KEY (`id_sekolah`);

--
-- Indexes for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD PRIMARY KEY (`id_siswa`),
  ADD UNIQUE KEY `nisn` (`nisn`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indexes for table `tb_transaksi_tabungan`
--
ALTER TABLE `tb_transaksi_tabungan`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_buku_tabungan` (`id_buku_tabungan`),
  ADD KEY `id_guru` (`id_guru`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_artikel`
--
ALTER TABLE `tb_artikel`
  MODIFY `id_artikel` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_buku_tabungan`
--
ALTER TABLE `tb_buku_tabungan`
  MODIFY `id_buku_tabungan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_galeri`
--
ALTER TABLE `tb_galeri`
  MODIFY `id_galeri` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_guru`
--
ALTER TABLE `tb_guru`
  MODIFY `id_guru` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_jenis_kelas`
--
ALTER TABLE `tb_jenis_kelas`
  MODIFY `id_jenis_kelas` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_jenis_tabungan`
--
ALTER TABLE `tb_jenis_tabungan`
  MODIFY `id_jenis_tabungan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_jurusan`
--
ALTER TABLE `tb_jurusan`
  MODIFY `id_jurusan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  MODIFY `id_kelas` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_krs`
--
ALTER TABLE `tb_krs`
  MODIFY `id_krs` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_mapel`
--
ALTER TABLE `tb_mapel`
  MODIFY `id_mapel` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_prestasi`
--
ALTER TABLE `tb_prestasi`
  MODIFY `id_prestasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_sekolah`
--
ALTER TABLE `tb_sekolah`
  MODIFY `id_sekolah` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  MODIFY `id_siswa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_transaksi_tabungan`
--
ALTER TABLE `tb_transaksi_tabungan`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_artikel`
--
ALTER TABLE `tb_artikel`
  ADD CONSTRAINT `tb_artikel_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_buku_tabungan`
--
ALTER TABLE `tb_buku_tabungan`
  ADD CONSTRAINT `tb_buku_tabungan_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `tb_siswa` (`id_siswa`),
  ADD CONSTRAINT `tb_buku_tabungan_ibfk_2` FOREIGN KEY (`id_jenis_tabungan`) REFERENCES `tb_jenis_tabungan` (`id_jenis_tabungan`);

--
-- Constraints for table `tb_galeri`
--
ALTER TABLE `tb_galeri`
  ADD CONSTRAINT `tb_galeri_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_guru`
--
ALTER TABLE `tb_guru`
  ADD CONSTRAINT `tb_guru_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_jenis_tabungan`
--
ALTER TABLE `tb_jenis_tabungan`
  ADD CONSTRAINT `tb_jenis_tabungan_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_jurusan`
--
ALTER TABLE `tb_jurusan`
  ADD CONSTRAINT `tb_jurusan_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD CONSTRAINT `tb_kelas_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`),
  ADD CONSTRAINT `tb_kelas_ibfk_2` FOREIGN KEY (`id_jurusan`) REFERENCES `tb_jurusan` (`id_jurusan`),
  ADD CONSTRAINT `tb_kelas_ibfk_3` FOREIGN KEY (`id_jenis_kelas`) REFERENCES `tb_jenis_kelas` (`id_jenis_kelas`),
  ADD CONSTRAINT `tb_kelas_ibfk_4` FOREIGN KEY (`wali_kelas`) REFERENCES `tb_guru` (`id_guru`);

--
-- Constraints for table `tb_kelas_siswa`
--
ALTER TABLE `tb_kelas_siswa`
  ADD CONSTRAINT `tb_kelas_siswa_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `tb_kelas` (`id_kelas`),
  ADD CONSTRAINT `tb_kelas_siswa_ibfk_2` FOREIGN KEY (`id_siswa`) REFERENCES `tb_siswa` (`id_siswa`);

--
-- Constraints for table `tb_krs`
--
ALTER TABLE `tb_krs`
  ADD CONSTRAINT `tb_krs_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `tb_siswa` (`id_siswa`),
  ADD CONSTRAINT `tb_krs_ibfk_2` FOREIGN KEY (`id_mapel`) REFERENCES `tb_mapel` (`id_mapel`);

--
-- Constraints for table `tb_mapel`
--
ALTER TABLE `tb_mapel`
  ADD CONSTRAINT `tb_mapel_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_pengampu_mapel`
--
ALTER TABLE `tb_pengampu_mapel`
  ADD CONSTRAINT `tb_pengampu_mapel_ibfk_1` FOREIGN KEY (`id_guru`) REFERENCES `tb_guru` (`id_guru`),
  ADD CONSTRAINT `tb_pengampu_mapel_ibfk_2` FOREIGN KEY (`id_mapel`) REFERENCES `tb_mapel` (`id_mapel`);

--
-- Constraints for table `tb_prestasi`
--
ALTER TABLE `tb_prestasi`
  ADD CONSTRAINT `tb_prestasi_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD CONSTRAINT `tb_siswa_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `tb_sekolah` (`id_sekolah`);

--
-- Constraints for table `tb_transaksi_tabungan`
--
ALTER TABLE `tb_transaksi_tabungan`
  ADD CONSTRAINT `tb_transaksi_tabungan_ibfk_1` FOREIGN KEY (`id_buku_tabungan`) REFERENCES `tb_buku_tabungan` (`id_buku_tabungan`),
  ADD CONSTRAINT `tb_transaksi_tabungan_ibfk_2` FOREIGN KEY (`id_guru`) REFERENCES `tb_guru` (`id_guru`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- CreateEnum
CREATE TYPE "RolUsuario" AS ENUM ('ADMIN', 'RRPP', 'CAJERO');

-- CreateEnum
CREATE TYPE "TipoBeneficio" AS ENUM ('ENTRADA_FREE', 'PULSERA_VIP', 'CONSUMICION');

-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "rol" "RolUsuario" NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "beneficios" (
    "id" SERIAL NOT NULL,
    "nombre" "TipoBeneficio" NOT NULL,

    CONSTRAINT "beneficios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuarios_beneficios" (
    "usuarioId" INTEGER NOT NULL,
    "beneficioId" INTEGER NOT NULL,

    CONSTRAINT "usuarios_beneficios_pkey" PRIMARY KEY ("usuarioId","beneficioId")
);

-- CreateTable
CREATE TABLE "invitados" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "ingreso" BOOLEAN NOT NULL DEFAULT false,
    "fechaCreacion" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fechaIngreso" TIMESTAMP(6),
    "cantidadAcompañantes" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "invitados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invitados_beneficios" (
    "invitadoId" INTEGER NOT NULL,
    "beneficioId" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "invitados_beneficios_pkey" PRIMARY KEY ("invitadoId","beneficioId")
);

-- CreateTable
CREATE TABLE "registros_domingo" (
    "id" SERIAL NOT NULL,
    "fecha" DATE NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "totalInvitados" INTEGER NOT NULL DEFAULT 0,
    "invitadosIngresados" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "registros_domingo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "beneficios_entregados" (
    "id" SERIAL NOT NULL,
    "registroDomingoId" INTEGER NOT NULL,
    "beneficioId" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "beneficios_entregados_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_username_key" ON "usuarios"("username");

-- CreateIndex
CREATE INDEX "usuarios_username_idx" ON "usuarios"("username");

-- CreateIndex
CREATE UNIQUE INDEX "beneficios_nombre_key" ON "beneficios"("nombre");

-- CreateIndex
CREATE INDEX "invitados_usuarioId_ingreso_idx" ON "invitados"("usuarioId", "ingreso");

-- CreateIndex
CREATE INDEX "registros_domingo_fecha_idx" ON "registros_domingo"("fecha");

-- CreateIndex
CREATE UNIQUE INDEX "registros_domingo_usuarioId_fecha_key" ON "registros_domingo"("usuarioId", "fecha");

-- CreateIndex
CREATE UNIQUE INDEX "beneficios_entregados_registroDomingoId_beneficioId_key" ON "beneficios_entregados"("registroDomingoId", "beneficioId");

-- AddForeignKey
ALTER TABLE "usuarios_beneficios" ADD CONSTRAINT "usuarios_beneficios_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuarios_beneficios" ADD CONSTRAINT "usuarios_beneficios_beneficioId_fkey" FOREIGN KEY ("beneficioId") REFERENCES "beneficios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invitados" ADD CONSTRAINT "invitados_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invitados_beneficios" ADD CONSTRAINT "invitados_beneficios_invitadoId_fkey" FOREIGN KEY ("invitadoId") REFERENCES "invitados"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invitados_beneficios" ADD CONSTRAINT "invitados_beneficios_beneficioId_fkey" FOREIGN KEY ("beneficioId") REFERENCES "beneficios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "registros_domingo" ADD CONSTRAINT "registros_domingo_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "beneficios_entregados" ADD CONSTRAINT "beneficios_entregados_registroDomingoId_fkey" FOREIGN KEY ("registroDomingoId") REFERENCES "registros_domingo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "beneficios_entregados" ADD CONSTRAINT "beneficios_entregados_beneficioId_fkey" FOREIGN KEY ("beneficioId") REFERENCES "beneficios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

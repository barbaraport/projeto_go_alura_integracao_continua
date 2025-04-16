package database

import (
	"log"
	"os"
	"github.com/guilhermeonrails/api-go-gin/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var (
	DB  *gorm.DB
	err error
)

func ConectaComBancoDeDados() {
	host := os.GetEnv("DB_HOST")
	user := os.GetEnv("DB_USER")
	password := os.GetEnv("DB_PASSWORD")
	name := os.GetEnv("DB_NAME")
	port := os.GetEnv("DB_PORT")

	stringDeConexao := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable", host, user, password, port)
	
	DB, err = gorm.Open(postgres.Open(stringDeConexao))
	
	if err != nil {
		log.Panic("Erro ao se conectar com o banco de dados")
	}

	_ = DB.AutoMigrate(&models.Aluno{})
}

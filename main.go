package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gofiber/fiber/v3"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	appVersion := os.Getenv("APP_VERSION")
	if appVersion == "" {
		log.Fatal("App version not loaded")
	}
	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("Port not loaded")
	}

	app := fiber.New(fiber.Config{
		AppName: fmt.Sprintf("Bento v%s", appVersion),
	})

	app.Get("/", func(c fiber.Ctx) error {
		return c.SendString("Hello!")
	})

	log.Fatal(app.Listen(port, fiber.ListenConfig{
		EnablePrefork: true,
	}))
}

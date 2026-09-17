const canvas =
    document.getElementById("networkCanvas");

const ctx =
    canvas.getContext("2d");

let points = [];

function resizeCanvas() {

    const rect =
        canvas.getBoundingClientRect();

    const dpr =
        window.devicePixelRatio || 1;

    canvas.width =
        rect.width * dpr;

    canvas.height =
        rect.height * dpr;

    ctx.setTransform(
        dpr,
        0,
        0,
        dpr,
        0,
        0
    );

    createPoints(
        rect.width,
        rect.height
    );
}

function createPoints(width, height) {

    const count = 10;

    points = Array.from(
        { length: count },
        (_, i) => {

            const angle =
                Math.PI * 2 * i / count;

            const radius =
                Math.min(width, height) * .3;

            return {

                x:
                    width / 2 +
                    Math.cos(angle) * radius,

                y:
                    height / 2 +
                    Math.sin(angle) * radius,

                vx:
                    (Math.random() - .5) * .18,

                vy:
                    (Math.random() - .5) * .18
            };
        }
    );
}

function draw() {

    const width =
        canvas.clientWidth;

    const height =
        canvas.clientHeight;

    ctx.clearRect(
        0,
        0,
        width,
        height
    );

    points.forEach(point => {

        point.x += point.vx;
        point.y += point.vy;

    });


    for (
        let i = 0;
        i < points.length;
        i++
    ) {

        for (
            let j = i + 1;
            j < points.length;
            j++
        ) {

            const a = points[i];
            const b = points[j];

            const dx = a.x - b.x;
            const dy = a.y - b.y;

            const distance =
                Math.sqrt(
                    dx * dx +
                    dy * dy
                );

            if (distance < width * .42) {

                ctx.beginPath();

                ctx.moveTo(
                    a.x,
                    a.y
                );

                ctx.lineTo(
                    b.x,
                    b.y
                );

                ctx.strokeStyle =
                    "rgba(39,227,162,.25)";

                ctx.stroke();
            }
        }
    }


    points.forEach(point => {

        ctx.beginPath();

        ctx.arc(
            point.x,
            point.y,
            3,
            0,
            Math.PI * 2
        );

        ctx.fillStyle =
            "#27e3a2";

        ctx.shadowColor =
            "#27e3a2";

        ctx.shadowBlur = 12;

        ctx.fill();

        ctx.shadowBlur = 0;

    });


    requestAnimationFrame(draw);
}


window.addEventListener(
    "resize",
    resizeCanvas
);

resizeCanvas();
draw();
